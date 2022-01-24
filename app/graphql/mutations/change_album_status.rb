# frozen_string_literal: true

module Mutations
  class ChangeAlbumStatus < ::Mutations::BaseMutation
    description 'アルバムステータス変更'

    argument :status, ::Types::Enums::StatusEnum, required: true, description: '変更したいステータス'
    argument :tweet, ::GraphQL::Types::Boolean, required: true, description: 'ツイートするか'
    argument :id, ::String, required: true, description: '変更したいID'

    field :result, ::GraphQL::Types::Boolean, null: false

    def mutate(id:, status:, tweet:)
      album = ::Album.find(id)
      album.status = status
      album.save!

      ::TwitterClient.post_album(album) if tweet

      ::Rails.cache.clear

      {
        result: true
      }
    end
  end
end
