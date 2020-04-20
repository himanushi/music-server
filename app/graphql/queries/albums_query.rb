module Queries
  class AlbumsQuery < BaseListQuery
    description "アルバム一覧取得"

    type [Types::Objects::AlbumType], null: false

    class AlbumsQueryOrder < Types::BaseEnum
      value "NAME",       value: "name", description: "名前順"
      value "NEW",        value: "albums.created_at", description: "新しい順"
      value "RELEASE",    value: "albums.release_date", description: "発売日順"
      value "POPULARITY", value: "spotify_albums.popularity", description: "人気順"
      value "TOTAL_TRACKS", value: "albums.total_tracks", description: "トラック数順"
    end

    class AlbumsConditions < Types::InputObjects::BaseInputObject
      argument :artists, IdInputObject, "アーティストID", required: false
    end

    argument :conditions, AlbumsConditions, required: false, description: "取得条件"
    argument :order,  AlbumsQueryOrder, required: true, description: "ソート対象"

    def resolve(limit:, offset:, order:, asc:, conditions: {})
      conditions = { **conditions, status: [:pending, :active] }
      sort_type = asc ? :asc : :desc
      Album.include_services.include_artists.
            where(conditions).
            order({ "#{order}": sort_type }).
            distinct.offset(offset).limit(limit)
    end
  end
end
