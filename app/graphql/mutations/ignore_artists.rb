# frozen_string_literal: true

module Mutations
  class IgnoreArtists < ::Mutations::BaseMutation
    description 'PENDING状態のアーティスト全てをIGNOREにする。よく考えてから実行すること。'

    field :result, ::GraphQL::Types::Boolean, null: true

    def mutate
      ::Artist.all_pending_to_ignore

      ::Rails.cache.clear

      {
        result: true
      }
    end
  end
end
