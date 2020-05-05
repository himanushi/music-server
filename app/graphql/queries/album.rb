module Queries
  class Album < BaseQuery
    description "アルバム情報取得"

    type Types::Objects::AlbumType, null: true

    argument :id,  TTID, required: true, description: "ID"

    def query(id:)
      if Rails.cache.exist?(id)
        Rails.cache.read(id)
      else
        album = ::Album.include_tracks.find_by(id: id)
        Rails.cache.write(id, album)
        album
      end
    end
  end
end
