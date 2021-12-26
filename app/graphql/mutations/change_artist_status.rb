# frozen_string_literal: true

module Mutations
  class ChangeArtistStatus < ::Mutations::BaseMutation
    description 'アーティストステータス変更'

    argument :status, ::Types::Enums::StatusEnum, required: true, description: '変更したいステータス'
    argument :id, ::String, required: true, description: '変更したいID'

    field :result, ::GraphQL::Types::Boolean, null: false

    def mutate(id:, status:)
      artist = ::Artist.find(id)
      artist.status = status
      artist.save!

      ::Rails.cache.clear

      {
        result: true
      }
    end
  end
end
