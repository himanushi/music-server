module Queries
  class Tracks < BaseListQuery
    description "トラック一覧取得"

    type [TrackType], null: false

    class TracksQueryOrderEnum < BaseEnum
      value "NEW", value: "tracks.created_at", description: "追加順"
      value "POPULARITY", value: "tracks.popularity", description: "人気順"
    end

    class TracksSortInputObject < BaseInputObject
      argument :order, TracksQueryOrderEnum, required: false, default_value: TracksQueryOrderEnum.values["NEW"].value, description: "並び順対象"
      argument :type,  SortEnum, required: false, default_value: SortEnum.values["DESC"].value, description: "並び順"
    end

    class TracksConditionsInputObject < BaseInputObject
      argument :name,     String, "トラック名(あいまい検索)", required: false
      argument :status,   [StatusEnum], "表示ステータス", required: false
      argument :favorite, Boolean, "お気に入り", required: false
    end

    argument :cursor, CursorInputObject, required: false, description: "取得件数", default_value: CursorInputObject.default_argument_values
    argument :sort, TracksSortInputObject, required: false, description: "取得順", default_value: TracksSortInputObject.default_argument_values
    argument :conditions, TracksConditionsInputObject, required: false, description: "取得条件"

    def list_query(cursor:, sort:, conditions: {})
      is_cache = true
      conditions = { status: [:active], **conditions }
      track_relation = ::Track

      # お気に入り検索
      if conditions.delete(:favorite)
        is_cache = false
        track_relation =
          track_relation.joins(:favorites).where(favorites: { user_id: context[:current_info][:user].id })
      end

      # 名前あいまい検索
      if conditions.has_key?(:name)
        name = conditions.delete(:name)
        ids = AppleMusicTrack.search(name).select(:track_id).pluck(:track_id)
        ids += SpotifyTrack.search(name).select(:track_id).pluck(:track_id)
        conditions = { **conditions, id: ids.uniq }
      end

      # なぜか eager_load だと limit 指定で正確な個数が取得できないため冗長な実装になっている
      ids = track_relation.where(conditions).order({ order => sort_type }).offset(offset).limit(limit).ids

      [
        is_cache,
        ::Track.include_services.where({ id: ids }).order({ order => sort_type })
      ]
    end
  end
end
