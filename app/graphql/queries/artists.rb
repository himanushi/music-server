module Queries
  class Artists < BaseQuery
    description "アーティスト一覧取得"

    type [ArtistType], null: false

    class ArtistsQueryOrder < BaseEnum
      value :name,       value: "artists.name", description: "名前順"
      value :new,        value: "artists.created_at", description: "追加順"
      value :popularity, value: "spotify_artists.popularity", description: "人気順"
    end

    class ArtistsConditions < BaseInputObject
      argument :albums, IdInputObject, "アルバムID", required: false
      argument :status, [StatusEnum], "表示ステータス", required: false
      argument :order,  ArtistsQueryOrder, required: false, description: "ソート対象"
      argument :sort,   SortEnum, required: false, default_value: SortEnum.values["desc"].value, description: "並び順"
    end

    argument :cursor, CursorInputObject, required: false, description: "取得件数"
    argument :conditions, ArtistsConditions, required: false, description: "取得条件"

    def query(cursor:, conditions: {})
      cache_key = {
        where:  conditions,
        order:  { order => sort },
        limit:  cursor[:limit],
        offset: cursor[:offset],
      }.to_s

      conditions = { status: [:pending, :active], **conditions }
      sort   = conditions.delete(:sort)
      order  = conditions.delete(:order)
      limit  = cursor.delete(:limit)
      offset = cursor.delete(:offset)

      artist_relation = ::Artist.include_services

      if conditions.has_key?(:albums)
        albums = ::Album.include_artists.include_tracks.where(id: conditions.delete(:albums)[:id])
        artist_ids = albums.map {|a| a.artists.ids }.flatten
        artist_ids += albums.map {|a| a.tracks.include_artists.map {|t| t.artists.ids } }.flatten
        conditions[:id] = artist_ids.uniq
      end

      if Rails.cache.exist?(cache_key)
        Rails.cache.read(cache_key)
      else
        artists =
          artist_relation.where({ **conditions }).
          order({ order => sort }).distinct.offset(offset).limit(limit).load
        Rails.cache.write(cache_key, artists)
        artists
      end
    end
  end
end
