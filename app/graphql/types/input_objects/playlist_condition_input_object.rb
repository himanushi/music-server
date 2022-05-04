# frozen_string_literal: true

module Types
  module InputObjects
    class PlaylistConditionInputObject < ::Types::InputObjects::BaseInputObject
      argument :order, ::Types::Enums::PlaylistConditionOrderEnum, required: true, description: 'order'
      argument :asc, ::GraphQL::Types::Boolean, required: true, description: 'asc'
      argument :favorite, ::GraphQL::Types::Boolean, required: true, description: 'お気に入り'
      argument :min_popularity, ::Integer, required: false, description: '人気度下限'
      argument :max_popularity, ::Integer, required: false, description: '人気度上限'
    end
  end
end
