module Queries
  class Playlists < BaseListQuery
    description "プレイリスト一覧取得"

    type [PlaylistType], null: false

    class PlaylistsQueryOrderEnum < BaseEnum
      value "NEW", value: "playlists.created_at", description: "作成日順"
      value "UPDATE", value: "playlists.updated_at", description: "更新日順"
    end

    class PlaylistsSortInputObject < BaseInputObject
      argument :order, PlaylistsQueryOrderEnum, required: false, default_value: PlaylistsQueryOrderEnum.values["NEW"].value, description: "並び順対象"
      argument :type,  SortEnum, required: false, default_value: SortEnum.values["DESC"].value, description: "並び順"
    end

    class PlaylistsConditionsInputObject < BaseInputObject
      argument :name, String, "プレイリスト名( like 検索)", required: false
      argument :is_mine, Boolean, "自身のプレイリスト取得", required: false, default_value: false
      argument :usernames, [String], "ユーザー名", required: false
      argument :favorite,  Boolean, "お気に入り", required: false
    end

    argument :cursor, CursorInputObject, required: false, description: "取得件数", default_value: CursorInputObject.default_argument_values
    argument :sort, PlaylistsSortInputObject, required: false, description: "取得順", default_value: PlaylistsSortInputObject.default_argument_values
    argument :conditions, PlaylistsConditionsInputObject, required: false, description: "取得条件"

    # TODO: それぞれの条件の検索を疎結合でリファクタすること
    def list_query(cursor:, sort:, conditions: {})
      conditions = { public_type: [:open, :anonymous_open], **conditions }
      relation   = ::Playlist.include_users.include_tracks

      # マイプレイリスト
      if conditions.delete(:is_mine)
        conditions = { **conditions, public_type: [:open, :non_open, :anonymous_open] }
        relation = relation.where(user: context[:current_info][:user])
      end

      # ユーザー公開お気に入り検索
      if conditions.has_key?(:usernames)
        is_cache = false
        usernames = conditions.delete(:usernames)
        user_ids =
          ::User.joins(:public_informations).where(username: usernames, public_informations: { public_type: :playlist }).ids
        ids = ::Favorite.where(user_id: user_ids, favorable_type: ::Playlist.name).pluck(:favorable_id)
        relation = relation.where(id: ids)
      end

      # お気に入り検索
      if conditions.delete(:favorite)
        is_cache = false
        relation =
          relation.joins(:favorites).where(favorites: { user_id: context[:current_info][:user].id })
      end

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
