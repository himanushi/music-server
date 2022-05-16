# frozen_string_literal: true

module Types
  module Objects
    class PlaylistObject < ::Types::Objects::BaseObject
      description 'プレイリスト'

      field :id,          ::String, null: false, description: 'ID'
      field :name,        ::String, null: false, description: 'タイトル'
      field :description, ::String, null: false, description: '説明'
      field :public_type, ::Types::Enums::PlaylistPublicTypeEnum, null: false, description: '公開種別'
      field :is_mine,     ::GraphQL::Types::Boolean, null: true, description: '自身のプレイリストか判定'
      field :created_at,  ::GraphQL::Types::ISO8601DateTime, null: false, description: '作成日'
      field :updated_at,  ::GraphQL::Types::ISO8601DateTime, null: false, description: '更新日'
      field :author,      ::Types::Objects::UserObject, null: true, description: '作者'
      field :track,       ::Types::Objects::TrackObject, null: true, description: 'ジャケットトラック'
      field :items,       [::Types::Objects::PlaylistItemObject], null: false, description: '曲一覧'

      def is_mine = object.user == context[:current_info][:user]

      def author
        object.user if !object.public_type_anonymous_open? || object.user == context[:current_info][:user]
      end

      def items
        object.playlist_items.includes({ track: :apple_music_tracks }).order(:track_number)
      end
    end
  end
end
