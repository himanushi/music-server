module Queries
  class Playlist < BaseQuery
    description "プレイリスト取得"

    type PlaylistType, null: true

    argument :id,  TTID, required: true, description: "ID"

    def query(id:)
      ::Playlist.include_users.include_tracks.find_by(id: id)
    end
  end
end
