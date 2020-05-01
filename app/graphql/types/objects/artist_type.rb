module Types
  module Objects
    class ArtistType < Types::Objects::BaseObject
      description 'アーティスト'

      field :id,                  TTID, null: false, description: "ID"
      field :name,                String, null: false, description: "名前"
      field :status,              StatusEnum, null: false, description: "ステータス"
      field :release_date,        GraphQL::Types::ISO8601DateTime, null: false, description: "発売日"
      field :created_at,          GraphQL::Types::ISO8601DateTime, null: false, description: "追加日"
      field :artwork_l,           ArtworkType, null: false, description: "大型アートワーク"
      field :artwork_m,           ArtworkType, null: false, description: "中型アートワーク"
      field :apple_music_artists, [AppleMusicArtistType], null: true, description: "Apple Music アーティスト"
      field :spotify_artists,     [SpotifyArtistType], null: true, description: "Spotify アーティスト"
      field :albums,              [AlbumType], null: true, description: "関連アルバム"
      field :tracks,              [TrackType], null: true, description: "関連曲"

      def name
        object.service.name
      end

      def artwork_l
        object.service.artwork_l
      end

      def artwork_m
        object.service.artwork_m
      end
    end
  end
end
