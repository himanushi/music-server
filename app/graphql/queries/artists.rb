module Queries
  class Artists < BaseListQuery
    description "アーティスト一覧取得"

    type [ArtistType], null: false

    class ArtistsQueryOrderEnum < BaseEnum
      value "NAME",       value: "artists.name", description: "名前順"
      value "NEW",        value: "artists.created_at", description: "追加順"
      value "POPULARITY", value: "artists.popularity", description: "人気順"
    end

    class ArtistsSortInputObject < BaseInputObject
      argument :order,  ArtistsQueryOrderEnum, required: false, default_value: ArtistsQueryOrderEnum.values["NAME"].value,description: "ソート対象"
      argument :type,   SortEnum, required: false, default_value: SortEnum.values["DESC"].value, description: "並び順"
    end

    class ArtistsConditionsInputObject < BaseInputObject
      argument :usernames, [String], "ユーザー名", required: false
      argument :albums, IdInputObject, "アルバムID", required: false
      argument :tracks, IdInputObject, "トラックID", required: false
      argument :name,   String, "アーティスト名(あいまい検索)", required: false
      argument :status, [StatusEnum], "表示ステータス", required: false
      argument :favorite, Boolean, "お気に入り", required: false
    end

    argument :cursor, CursorInputObject, required: false, description: "取得件数", default_value: CursorInputObject.default_argument_values
    argument :sort, ArtistsSortInputObject, required: false, description: "取得順", default_value: ArtistsSortInputObject.default_argument_values
    argument :conditions, ArtistsConditionsInputObject, required: false, description: "取得条件"

    def list_query(cursor:, sort:, conditions: {})
      is_cache = true
      conditions = { status: [:active], **conditions }
      artist_relation = ::Artist.include_services.include_album_services

      # 名前あいまい検索
      if conditions.has_key?(:name)
        name = conditions.delete(:name)
        artist_relation = artist_relation.where("artists.name like :name", name: "%#{name}%")
      end

      # ユーザー公開お気に入り検索
      if conditions.has_key?(:usernames)
        is_cache = false
        usernames = conditions.delete(:usernames)
        user_ids =
          ::User.joins(:public_informations).where(username: usernames, public_informations: { public_type: :artist }).ids
        artist_ids = ::Favorite.where(user_id: user_ids, favorable_type: ::Artist.name).pluck(:favorable_id)
        artist_relation = artist_relation.where(id: artist_ids)
      end

      # お気に入り検索
      if conditions.delete(:favorite)
        is_cache = false
        artist_relation =
          artist_relation.joins(:favorites).where(favorites: { user_id: context[:current_info][:user].id })
      end

      if conditions.has_key?(:albums)
        albums = ::Album.include_artists.include_tracks.where(id: conditions.delete(:albums)[:id])
        artist_ids = albums.map {|a| a.artists.ids }.flatten
        artist_ids += albums.map {|a| a.tracks.include_artists.map {|t| t.artists.ids } }.flatten
        artist_relation = artist_relation.where(id: artist_ids)
      end

      if conditions.has_key?(:tracks)
        artist_relation = artist_relation.include_tracks.where(tracks: { id: conditions.delete(:tracks)[:id] })
      end

      [
        is_cache,
        artist_relation.where({ **conditions }).
          order({ order => sort_type }).distinct.offset(offset).limit(limit)
      ]
    end
  end
end
