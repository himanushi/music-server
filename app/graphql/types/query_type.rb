module Types
  class QueryType < Types::Objects::BaseObject
    field :apple_music_token, resolver: Queries::AppleMusicToken
    field :spotify_login, resolver: Queries::SpotifyLogin
    field :spotify_logout, resolver: Queries::SpotifyLogout
    field :me,            resolver: Queries::Me
    field :artist,        resolver: Queries::Artist
    field :artists,       resolver: Queries::Artists
    field :album,         resolver: Queries::Album
    field :albums,        resolver: Queries::Albums
    field :albums_count,  resolver: Queries::AlbumsCount
    field :tracks,        resolver: Queries::Tracks
    field :playlist,      resolver: Queries::Playlist
    field :playlists,     resolver: Queries::Playlists
    field :my_playlists,  resolver: Queries::MyPlaylists
    field :roles,         resolver: Queries::Roles
  end
end
