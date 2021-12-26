# frozen_string_literal: true

module Mutations
  class AddAlbum < ::Mutations::BaseMutation
    description 'アルバムを追加する'

    argument :apple_music_id, ::String, required: true, description: 'Apple Music か iTunes のアルバムを登録'

    field :album, ::Types::Objects::AlbumObject, null: true, description: '追加されたアルバム'

    def mutate(apple_music_id:)
      am_album = ::AppleMusic::Album.create_full(apple_music_id, force: true)

      ::Rails.cache.clear

      {
        album: am_album.album
      }
    end
  end
end
