# frozen_string_literal: true

module Mutations
  class AddArtist < ::Mutations::BaseMutation
    description 'アーティストを追加する'

    argument :apple_music_id, ::String, required: true, description: 'アーティストを登録'

    field :artist, ::Types::Objects::ArtistObject, null: true, description: '追加されたアーティスト'

    def mutate(apple_music_id:)
      artist = ::AppleMusic::Artist.create_full(apple_music_id, force: true)

      ::Rails.cache.clear

      {
        artist: artist
      }
    end
  end
end
