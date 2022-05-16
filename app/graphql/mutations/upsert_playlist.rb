# frozen_string_literal: true

module Mutations
  class UpsertPlaylist < ::Mutations::BaseMutation
    description 'プレイリストを作成更新する'

    argument :playlist_id, ::String, required: false, description: 'IDがない場合は作成'
    argument :name, ::String, required: true, description: 'タイトル'
    argument :description, ::String, required: false, description: '説明'
    argument :public_type, ::Types::Enums::PlaylistPublicTypeEnum, required: true, description: '公開種別'
    argument :track_ids, [::String], required: false, description: 'トラックID'

    field :playlist, ::Types::Objects::PlaylistObject, null: true, description: '作成更新されたプレイリスト'

    def mutate(name:, public_type:, playlist_id: nil, description: '', track_ids: [])
      ::Playlist.validate_author!(playlist_id, context[:current_info][:user].id) if playlist_id

      playlist =
        ::Playlist.create_or_update(
          id: playlist_id,
          user_id: context[:current_info][:user].id,
          name: name,
          description: description,
          public_type: public_type,
          track_ids: track_ids
        )

      {
        playlist: playlist
      }
    end
  end
end
