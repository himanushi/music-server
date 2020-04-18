module Queries
  class AlbumsQuery < BaseListQuery
    description "アルバム一覧取得"

    type [Types::Objects::AlbumType], null: false

    class AlbumsQueryOrder < Types::BaseEnum
      value "NAME",       value: "name", description: "名前順"
      value "NEW",        value: "albums.created_at", description: "新しい順"
      value "RELEASE",    value: "albums.release_date", description: "発売日順"
      value "POPULARITY", value: "spotify_albums.popularity", description: "人気順"
    end

    argument :order,  AlbumsQueryOrder, required: true, description: "ソート対象"

    def resolve(limit:, offset:, order:, asc:)
      sort_type = asc ? :asc : :desc
      Album.include_services.order({ "#{order}": sort_type }).distinct.offset(offset).limit(limit)
    end
  end
end
