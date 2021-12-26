# frozen_string_literal: true

module Queries
  class PlaylistQuery < ::Queries::BaseQuery
    description 'プレイリスト取得'

    type ::Types::Objects::PlaylistObject, null: true

    argument :id, ::String, required: true, description: 'プレイリストID'

    def query(id:)
      playlist = ::Playlist.includes(:user, :track).find_by(id: id)

      if playlist && (playlist.user == context[:current_info][:user] || %w[
        open
        anonymous_open
      ].include?(playlist.public_type))

        playlist
      end
    end
  end
end
