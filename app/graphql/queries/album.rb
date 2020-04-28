module Queries
  class Album < BaseQuery
    description "アルバム情報取得"

    type Types::Objects::AlbumType, null: true

    argument :id,  TTID, required: true, description: "ID"

    def query(id:)
      ::Album.find_by(id: id)
    end
  end
end
