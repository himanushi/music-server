module Queries
  class Albums < BaseListQuery
    description "アルバム一覧取得"

    type [AlbumType], null: false

    class AlbumsQueryOrderEnum < BaseEnum
      value "NEW",        value: "albums.created_at", description: "追加順"
      value "RELEASE",    value: "albums.release_date", description: "発売日順"
      value "POPULARITY", value: "spotify_albums.popularity", description: "人気順"
    end

    class AlbumsSortInputObject < BaseInputObject
      argument :order, AlbumsQueryOrderEnum, required: false, default_value: AlbumsQueryOrderEnum.values["RELEASE"].value, description: "並び順対象"
      argument :type,  SortEnum, required: false, default_value: SortEnum.values["DESC"].value, description: "並び順"
    end

    class AlbumsConditionsInputObject < BaseInputObject
      argument :artists, IdInputObject, "アーティストID", required: false
      argument :status,  [StatusEnum], "表示ステータス", required: false
    end

    argument :cursor, CursorInputObject, required: false, description: "取得件数", default_value: CursorInputObject.default_argument_values
    argument :sort, AlbumsSortInputObject, required: false, description: "取得順", default_value: AlbumsSortInputObject.default_argument_values
    argument :conditions, AlbumsConditionsInputObject, required: false, description: "取得条件"

    def list_query(cursor:, sort:, conditions: {})
      conditions = { status: [:pending, :active], **conditions }
      album_relation = ::Album.include_services

      if conditions.has_key?(:artists)
        ids = conditions.delete(:artists)[:id]
        album_ids = ::Album.include_artists.where(artists: { id: ids }).ids
        track_ids = ::Track.include_artists.where(artists: { id: ids }).ids
        album_ids += ::Album.include_tracks.where(tracks: { id: track_ids }).ids
        conditions[:id] = album_ids.uniq
      end

      album_relation.where(conditions).
        order({ order => sort_type }).
        distinct.offset(offset).limit(limit)
    end
  end
end
