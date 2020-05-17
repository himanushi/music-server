module Types
  module Objects
    class AlbumType < BaseObject
      description 'アルバム'

      field :id,                TTID, null: false, description: "ID"
      field :name,              String, null: false, description: "タイトル"
      field :status,            StatusEnum, null: false, description: "ステータス"
      field :total_tracks,      PositiveNumber, null: false, description: "トラック数"
      field :release_date,      GraphQL::Types::ISO8601DateTime, null: false, description: "発売日"
      field :created_at,        GraphQL::Types::ISO8601DateTime, null: false, description: "追加日"
      field :artwork_l,         ArtworkType, null: false, description: "大型アートワーク"
      field :artwork_m,         ArtworkType, null: false, description: "中型アートワーク"
      field :apple_music_album, AppleMusicAlbumType, null: true, description: "Apple Music アルバム"
      field :itunes_album,      AppleMusicAlbumType, null: true, description: "iTunes アルバム"
      field :spotify_album,     SpotifyAlbumType, null: true, description: "Spotify アルバム"
      field :tracks,            [TrackType], null: false, description: "トラック"

      def name
        object.service.name
      end

      def artwork_l
        object.service.artwork_l
      end

      def artwork_m
        object.service.artwork_m
      end

      def tracks
        # TODO: トラックからアルバムを特定できない問題を解決すること
        object.tracks.include_album_services.
        order(
            "apple_music_tracks.disc_number",
            "apple_music_tracks.track_number",
            "spotify_tracks.disc_number",
            "spotify_tracks.track_number",
          )
      end
    end
  end
end
