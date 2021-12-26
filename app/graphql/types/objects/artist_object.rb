# frozen_string_literal: true

module Types
  module Objects
    class ArtistObject < ::Types::Objects::BaseObject
      description 'アーティスト'

      field :id,           ::String, null: false, description: 'ID'
      field :name,         ::String, null: false, description: '名前'
      field :status,       ::Types::Enums::StatusEnum, null: false, description: 'ステータス'
      field :release_date, ::GraphQL::Types::ISO8601DateTime, null: false, description: '発売日'
      field :created_at,   ::GraphQL::Types::ISO8601DateTime, null: false, description: '追加日'
      field :artwork_l,    ::Types::Objects::ArtworkObject, null: false, description: '大型アートワーク'
      field :artwork_m,    ::Types::Objects::ArtworkObject, null: false, description: '中型アートワーク'
    end
  end
end
