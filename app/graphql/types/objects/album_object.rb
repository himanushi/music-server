# frozen_string_literal: true

module Types
  module Objects
    class AlbumObject < ::Types::Objects::BaseObject
      description 'アルバム'

      field :id,             ::String, null: false, description: 'ID'
      field :name,           ::String, null: false, description: 'タイトル'
      field :upc,            ::String, null: false, description: 'upc'
      field :record_label,   ::String, null: false, description: 'レーベル'
      field :copyright,      ::String, null: false, description: 'コピーライト'
      field :status,         ::Types::Enums::StatusEnum, null: false, description: 'ステータス'
      field :total_tracks,   ::Integer, null: false, description: 'トラック数'
      field :release_date,   ::GraphQL::Types::ISO8601DateTime, null: false, description: '発売日'
      field :created_at,     ::GraphQL::Types::ISO8601DateTime, null: false, description: '追加日'
      field :artwork_l,      ::Types::Objects::ArtworkObject, null: true, description: '大型アートワーク'
      field :artwork_m,      ::Types::Objects::ArtworkObject, null: true, description: '中型アートワーク'
      field :tracks,         [::Types::Objects::TrackObject], null: false, description: 'トラック'
      field :apple_music_id, ::String, null: false, description: 'Apple Music ID'
      field :apple_music_playable, ::GraphQL::Types::Boolean, null: false, description: 'iTunes 判定'
    end
  end
end
