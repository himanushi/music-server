# frozen_string_literal: true

module Types
  module InputObjects
    class PlaylistConditionInputObject < ::Types::InputObjects::BaseInputObject
      argument :order, ::Types::Enums::PlaylistConditionOrderEnum, required: true, description: 'order'
      argument :direction, ::Types::Enums::SortEnum, required: true, description: '並び順'
      argument :favorite, ::GraphQL::Types::Boolean, required: true, description: 'お気に入り'
      argument :min_popularity, ::Integer, required: false, description: '人気度下限'
      argument :max_popularity, ::Integer, required: false, description: '人気度上限'
      argument :from_release_date, ::String, required: false, description: '配信検索開始日'
      argument :to_release_date, ::String, required: false, description: '配信検索終了日'
    end
  end
end
