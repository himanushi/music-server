# frozen_string_literal: true

module Mutations
  class DeletePlaylist < ::Mutations::BaseMutation
    description 'プレイリストを削除する'

    argument :playlist_id, ::String, required: false

    field :result, ::GraphQL::Types::Boolean, null: true

    def mutate(playlist_id:)
      ::Playlist.validate_author!(playlist_id, context[:current_info][:user].id) if playlist_id
      ::Playlist.find(playlist_id).destroy!

      {
        result: true
      }
    end
  end
end
