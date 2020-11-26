module Types
  module Objects
    class PlaylistItemType < BaseObject
      description 'プレイリストトラック'

      field :id,           TTID, null: false, description: "ID"
      field :track,        TrackType, null: false, description: "曲"
      field :track_number, Integer, null: false, description: "トラックナンバー"
    end
  end
end
