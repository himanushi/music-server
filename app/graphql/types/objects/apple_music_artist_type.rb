module Types
  module Objects
    class AppleMusicArtistType < Types::Objects::BaseObject
      description 'Apple Music アーティスト'

      field :id,   TTID, null: false, description: "ID"
      field :name, String, null: false, description: "名前"
      field :apple_music_id, String, null: false, description: "Apple Music ID"
    end
  end
end
