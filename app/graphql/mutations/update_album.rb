# frozen_string_literal: true

module Mutations
  class UpdateAlbum < ::Mutations::BaseMutation
    description 'アルバムを最新状態にする'

    argument :album_id, ::String, required: true, description: '指定したアルバムのトラック(ISRC)を含んでいる別音楽サービスのアルバムを一括登録'

    field :album, ::Types::Objects::AlbumObject, null: true, description: '追加されたアルバム'

    def mutate(album_id:)
      album = ::Album.find(album_id).update_services

      ::Rails.cache.clear

      {
        album: album.reload
      }
    end
  end
end
