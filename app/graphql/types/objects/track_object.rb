# frozen_string_literal: true

module Types
  module Objects
    class TrackObject < ::Types::Objects::BaseObject
      description 'トラック'

      field :id,             ::String, null: false, description: 'ID'
      field :isrc,           ::String, null: false, description: '国際標準レコーディングコード'
      field :name,           ::String, null: false, description: 'タイトル'
      field :status,         ::Types::Enums::StatusEnum, null: false, description: 'ステータス'
      field :disc_number,    ::Integer, null: false, description: 'ディスク番号'
      field :track_number,   ::Integer, null: false, description: 'トラック番号'
      field :duration_ms,    ::Integer, null: false, description: '再生時間'
      field :preview_url,    ::String, null: true, description: 'プレビューURL'
      field :popularity,     ::Integer, null: false, description: '人気度'
      field :artwork_m,      ::Types::Objects::ArtworkObject, null: false, description: '中型アートワーク'
      field :artwork_l,      ::Types::Objects::ArtworkObject, null: false, description: '大型アートワーク'
      field :apple_music_id, ::String, null: false, description: 'Apple Music ID'
      field :apple_music_playable, ::GraphQL::Types::Boolean, null: false, description: 'iTunes 判定'
    end
  end
end
