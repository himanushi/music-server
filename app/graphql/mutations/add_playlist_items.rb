# frozen_string_literal: true

module Mutations
  class AddPlaylistItems < ::Mutations::BaseMutation
    description 'プレイリストに曲を追加する'

    argument :playlist_id, ::String, required: true, description: 'プレイリストID'
    argument :track_ids, [::String], required: true, description: '追加したい曲ID'

    field :playlist, ::Types::Objects::PlaylistObject, null: true, description: '曲追加されたプレイリスト'

    def mutate(playlist_id:, track_ids:)
      ::Playlist.validate_author!(playlist_id, context[:current_info][:user].id)
      playlist = ::Playlist.find(playlist_id).add_items(track_ids)

      {
        playlist: playlist
      }
    end
  end
end
