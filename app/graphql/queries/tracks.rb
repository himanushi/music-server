module Queries
  class Tracks < BaseListQuery
    description "トラック一覧取得"

    type [TrackType], null: false

    class TracksQueryOrderEnum < BaseEnum
      value "NAME",       value: "NAME", description: "名前順"
      value "NEW",        value: "tracks.created_at", description: "追加順"
      value "POPULARITY", value: "spotify_tracks.popularity", description: "人気順"
    end

    class TracksSortInputObject < BaseInputObject
      argument :order, TracksQueryOrderEnum, required: false, default_value: TracksQueryOrderEnum.values["NAME"].value, description: "並び順対象"
      argument :type,  SortEnum, required: false, default_value: SortEnum.values["DESC"].value, description: "並び順"
    end

    class TracksConditionsInputObject < BaseInputObject
      argument :name,    String, "トラック名(あいまい検索)", required: false
      argument :status,  [StatusEnum], "表示ステータス", required: false
    end

    argument :cursor, CursorInputObject, required: false, description: "取得件数", default_value: CursorInputObject.default_argument_values
    argument :sort, TracksSortInputObject, required: false, description: "取得順", default_value: TracksSortInputObject.default_argument_values
    argument :conditions, TracksConditionsInputObject, required: false, description: "取得条件"

    def list_query(cursor:, sort:, conditions: {})
      # TODO: お気に入り対応
      is_cache = true
      conditions = { status: [:active], **conditions }
      track_relation = ::Track.include_services

      # 名前順の場合は音楽サービスの名前基準のため整形する
      track_relation =
        if sort[:order] == "NAME"
          track_relation.order([
            { "apple_music_tracks.name": sort[:type] },
            { "spotify_tracks.name": sort[:type] }
          ])
        else
          track_relation.order({ order => sort_type })
        end

      # 名前あいまい検索
      if conditions.has_key?(:name)
        name = conditions.delete(:name)
        track_relation =
          track_relation.where(
            "apple_music_tracks.name like :name or spotify_tracks.name like :name",
            name: "%#{name}%"
          )
      end

      [
        is_cache,
        track_relation.where(conditions).
          distinct.offset(offset).limit(limit)
      ]
    end
  end
end
