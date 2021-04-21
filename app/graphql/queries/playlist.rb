module Queries
  class Playlist < BaseQuery
    description "プレイリスト取得"

    type PlaylistType, null: true

    argument :id,  TTID, required: true, description: "ID"

    def query(id:)
      playlist = ::Playlist.include_users.include_tracks.find_by(id: id)
      if (playlist.user == context[:current_info][:user])
        playlist
      elsif ["open", "anonymous_open"].include?(playlist.public_type)
        playlist
      else
        nil
      end
    end
  end
end
