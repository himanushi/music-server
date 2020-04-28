module Queries
  class ArtistsQuery < BaseListQuery
    description "アーティスト一覧取得"

    type [Types::Objects::ArtistType], null: false

    class ArtistsQueryOrder < Types::BaseEnum
      value "NEW",        value: "artists.created_at", description: "新しい順"
      value "POPULARITY", value: "spotify_artists.popularity", description: "人気順"
    end

    argument :order, ArtistsQueryOrder, required: false, description: "ソート対象"

    def query(limit:, offset:, order:, asc:)
      sort_type = asc ? :asc : :desc
      Artist.include_services.where(status: [:pending, :active]).order({ "#{order}": sort_type }).distinct.offset(offset).limit(limit)
    end
  end
end
