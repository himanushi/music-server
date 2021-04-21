module Queries
  class MyPlaylists < BaseListQuery
    description "マイプレイリスト一覧取得"

    type [PlaylistType], null: false

    class MyPlaylistsQueryOrderEnum < BaseEnum
      value "NEW", value: "playlists.created_at", description: "作成日順"
      value "UPDATED", value: "playlists.updated_at", description: "更新日順"
    end

    class MyPlaylistsSortInputObject < BaseInputObject
      argument :order, MyPlaylistsQueryOrderEnum, required: false, default_value: MyPlaylistsQueryOrderEnum.values["NEW"].value, description: "並び順対象"
      argument :type,  SortEnum, required: false, default_value: SortEnum.values["DESC"].value, description: "並び順"
    end

    class MyPlaylistsConditionsInputObject < BaseInputObject
      argument :name, String, "プレイリスト名( like 検索)", required: false
    end

    argument :cursor, CursorInputObject, required: false, description: "取得件数", default_value: CursorInputObject.default_argument_values
    argument :sort, MyPlaylistsSortInputObject, required: false, description: "取得順", default_value: MyPlaylistsSortInputObject.default_argument_values
    argument :conditions, MyPlaylistsConditionsInputObject, required: false, description: "取得条件"

    def list_query(cursor:, sort:, conditions: {})
      conditions = { public_type: [:open, :no_name_open], **conditions }
      relation   = ::Playlist.include_users.include_tracks

      relation = relation.where(user: context[:current_info][:user])

      # 名前あいまい検索
      if conditions.has_key?(:name)
        name = conditions.delete(:name)
        relation = relation.where("playlists.name like :name", name: "%#{name}%")
      end

      [
        is_cache = false,
        relation.where(conditions).
          order([{ order => sort_type }, { id: sort_type }]).
          distinct.offset(offset).limit(limit)
      ]
    end
  end
end
