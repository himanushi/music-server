module Queries
  class AlbumQuery < BaseQuery
    description "アルバム情報取得"

    type Types::Objects::AlbumType, null: true

    argument :id,  TTID, required: true, description: "ID"

    def resolve(id:)
      Album.include_services.find_by(id: id)
    end
  end
end
