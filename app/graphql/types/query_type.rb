module Types
  class QueryType < Types::Objects::BaseObject
    field :apple_music_token, resolver: Queries::AppleMusicToken
    field :me,        resolver: Queries::Me
    field :artist,    resolver: Queries::Artist
    field :artists,   resolver: Queries::Artists
    field :album,     resolver: Queries::Album
    field :albums,    resolver: Queries::Albums
    field :track,     resolver: Queries::Track
    field :tracks,    resolver: Queries::Tracks
    field :playlist,  resolver: Queries::Playlist
    field :playlists, resolver: Queries::Playlists
    field :radio,     resolver: Queries::Radio
    field :radios,    resolver: Queries::Radios
    field :roles,     resolver: Queries::Roles
  end
end
