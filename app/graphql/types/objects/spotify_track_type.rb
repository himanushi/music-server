module Types
  module Objects
    class SpotifyTrackType < Types::Objects::BaseObject
      description 'Spotify トラック'

      field :id,   TTID, null: false, description: "ID"
      field :name, String, null: false, description: "タイトル"
      field :spotify_id, String, null: false, description: "Spotify ID"
    end
  end
end
