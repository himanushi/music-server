module Queries
  class Track < BaseQuery
    description "トラック情報取得"

    type Types::Objects::TrackType, null: true

    argument :id,  TTID, required: true, description: "ID"

    def query(id:)
      if Rails.cache.exist?(id)
        Rails.cache.read(id)
      else
        track = ::Track.find_by(id: id)
        Rails.cache.write(id, track)
        track
      end
    end
  end
end
