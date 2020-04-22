module Types
  module Objects
    class SpotifyArtistType < Types::Objects::BaseObject
      description 'Spotify アーティスト'

      field :id,   TTID, null: false, description: "ID"
      field :name, String, null: false, description: "名前"
      field :spotify_id, String, null: false, description: "Spotify ID"
    end
  end
end
