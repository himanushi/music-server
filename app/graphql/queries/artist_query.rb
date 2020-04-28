module Queries
  class ArtistQuery < BaseQuery
    description "アーティスト取得"

    type Types::Objects::ArtistType, null: true

    argument :id,  TTID, required: true, description: "ID"

    def query(id:)
      Artist.include_albums.find_by(id: id)
    end
  end
end
