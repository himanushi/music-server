module Queries
  class Albums < BaseQuery
    description "アルバム一覧取得"

    type [AlbumType], null: false

    class AlbumsQueryOrder < BaseEnum
      value :new,        value: "albums.created_at", description: "追加順"
      value :release,    value: "albums.release_date", description: "発売日順"
      value :popularity, value: "spotify_albums.popularity", description: "人気順"
    end

    class AlbumsConditions < BaseInputObject
      argument :artists, IdInputObject, "アーティストID", required: false
      argument :status,  [StatusEnum], "表示ステータス", required: false
      argument :order,   AlbumsQueryOrder, required: false, default_value: AlbumsQueryOrder.values["new"].value, description: "並び順対象"
      argument :sort,    SortEnum, required: false, default_value: SortEnum.values["desc"].value, description: "並び順"
    end

    argument :cursor, CursorInputObject, required: false, description: "取得件数"
    argument :conditions, AlbumsConditions, required: false, description: "取得条件"

    def query(limit:, offset:, conditions: {})
      cache_key = { where: conditions, order: { order => sort }, limit: limit, offset: offset }.to_s

      conditions = { status: ["pending", "active"], **conditions }
      order = conditions.delete(:order)
      sort = conditions.delete(:sort)

      album_relation = ::Album.include_services

      if conditions.has_key?(:artists)
        ids = conditions.delete(:artists)[:id]
        album_ids = ::Album.include_artists.where(artists: { id: ids }).ids
        track_ids = ::Track.include_artists.where(artists: { id: ids }).ids
        album_ids += ::Album.include_tracks.where(tracks: { id: track_ids }).ids
        conditions[:id] = album_ids.uniq
      end

      if Rails.cache.exist?(cache_key)
        Rails.cache.read(cache_key)
      else
        albums =
          album_relation.where(conditions).
            order({ "#{order}": sort_type }).
            distinct.offset(offset).limit(limit).load
        Rails.cache.write(cache_key, albums)
        albums
      end
    end
  end
end
