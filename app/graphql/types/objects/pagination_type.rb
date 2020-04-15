module Types
  module Objects
    class PaginationType < Types::Objects::BaseObject
      description 'ページネーション'

      field :name,              String, null: false, description: "タイトル"
      field :total_tracks,      PositiveNumber, null: false, description: "トラック数"
      field :release_date,      GraphQL::Types::ISO8601DateTime, null: false, description: "発売日"
      field :created_at,        GraphQL::Types::ISO8601DateTime, null: false, description: "追加日"
      field :artwork_l,         ArtworkType, null: true, description: "大型アートワーク"
      field :artwork_m,         ArtworkType, null: true, description: "中型アートワーク"
      field :apple_music_album, AppleMusicAlbumType, null: true, description: "Apple Music アルバム"
      field :spotify_album,     SpotifyAlbumType, null: true, description: "Spotify アルバム"
    end
  end
end
