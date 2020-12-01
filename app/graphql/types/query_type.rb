module Types
  class QueryType < Types::Objects::BaseObject
    field :apple_music_token, resolver: Queries::AppleMusicToken
    field :spotify_token, resolver: Queries::SpotifyToken
    field :me,        resolver: Queries::Me
    field :artist,    resolver: Queries::Artist
    field :artists,   resolver: Queries::Artists
    field :album,     resolver: Queries::Album
    field :albums,    resolver: Queries::Albums
    field :tracks,    resolver: Queries::Tracks
    field :playlist,  resolver: Queries::Playlist
    field :playlists, resolver: Queries::Playlists
    field :roles,     resolver: Queries::Roles
  end
end
