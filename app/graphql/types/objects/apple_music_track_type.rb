module Types
  module Objects
    class AppleMusicTrackType < Types::Objects::BaseObject
      description 'Apple Music トラック'

      field :id,   TTID, null: false, description: "ID"
      field :name, String, null: false, description: "タイトル"
      field :apple_music_id, String, null: false, description: "Apple Music ID"
    end
  end
end
