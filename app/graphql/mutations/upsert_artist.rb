class Mutations::UpsertArtist < Mutations::BaseMutation
  description "アーティストを最新の状態にする"

  argument :apple_music_id, String, required: false, description: "Apple Music のアーティストを登録"
  argument :spotify_id, String, required: false, description: "Spotify のアーティストを登録"

  field :artists, [ArtistType], null: true, description: "追加されたアーティスト"
  field :error, String, null: true

  def mutate(apple_music_id:, spotify_id:)
    begin
      artists = []

      if apple_music_id.present?
        artists << AppleMusicArtist.create_by_apple_music_id(apple_music_id)&.artist
      end

      if spotify_id.present?
        artists << SpotifyArtist.create_by_spotify_id(spotify_id)&.artist
      end

      artists.compact.uniq.map {|artist| artist.create_albums }

      {
        artists: artists.compact.uniq,
        error: nil,
      }
    rescue => error
      {
        artists: nil,
        error: error.message,
      }
    end
  end
end
