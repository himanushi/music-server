# frozen_string_literal: true

module Mutations
  class ForceIgnoreAlbum < ::Mutations::BaseMutation
    description '対象アルバムを除外コンテンツに登録する'

    argument :album_id, ::String, required: true, description: '除外コンテンツに登録したいアルバムID'

    field :result, ::GraphQL::Types::Boolean, null: false

    def mutate(album_id:)
      album = ::Album.find(album_id)
      album.force_ignore

      ::Rails.cache.clear

      {
        result: true
      }
    end
  end
end
