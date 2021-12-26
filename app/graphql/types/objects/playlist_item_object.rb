# frozen_string_literal: true

module Types
  module Objects
    class PlaylistItemObject < ::Types::Objects::BaseObject
      description 'プレイリストトラック'

      field :id,           ::String, null: false, description: 'ID'
      field :track,        ::Types::Objects::TrackObject, null: false, description: '曲'
      field :track_number, ::Integer, null: false, description: 'トラックナンバー'
    end
  end
end
