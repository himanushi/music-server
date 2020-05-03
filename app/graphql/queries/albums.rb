module Queries
  class Albums < BaseList
    description "アルバム一覧取得"

    type [Types::Objects::AlbumType], null: false

    class AlbumsQueryOrder < BaseEnum
      value "NAME",       value: "name", description: "名前順"
      value "NEW",        value: "albums.created_at", description: "新しい順"
      value "RELEASE",    value: "albums.release_date", description: "発売日順"
      value "POPULARITY", value: "spotify_albums.popularity", description: "人気順"
      value "TOTAL_TRACKS", value: "albums.total_tracks", description: "トラック数順"
    end

    class AlbumsConditions < BaseInputObject
      argument :artists, IdInputObject, "アーティストID", required: false
      argument :status,  [Types::Enums::StatusEnum], "表示ステータス", required: false
    end

    argument :conditions, AlbumsConditions, required: false, description: "取得条件"
    argument :order,  AlbumsQueryOrder, required: true, description: "ソート対象"

    def query(limit:, offset:, order:, asc:, conditions: {})
      conditions = { status: ["pending", "active"], **conditions }
      sort_type = asc ? :asc : :desc

      album_relation = ::Album.include_services

      if conditions.has_key?(:artists)
        ids = conditions.delete(:artists)[:id]
        album_ids = ::Album.include_artists.where(artists: { id: ids }).ids
        track_ids = ::Track.include_artists.where(artists: { id: ids }).ids
        album_ids += ::Album.include_tracks.where(tracks: { id: track_ids }).ids
        conditions[:id] = album_ids.uniq
      end

      album_relation.
        where(conditions).
        order({ "#{order}": sort_type }).
        distinct.offset(offset).limit(limit)
    end
  end
end
