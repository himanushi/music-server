# frozen_string_literal: true

module Mutations
  class IgnoreAlbums < ::Mutations::BaseMutation
    description 'PENDING状態のアルバム全てをIGNOREにする。よく考えてから実行すること。'

    field :result, ::GraphQL::Types::Boolean, null: true

    def mutate
      ::Album.all_pending_to_ignore

      ::Rails.cache.clear

      {
        result: true
      }
    end
  end
end
