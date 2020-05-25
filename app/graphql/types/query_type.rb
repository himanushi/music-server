module Types
  class QueryType < Types::Objects::BaseObject
    field :me,      resolver: Queries::Me
    field :artist,  resolver: Queries::Artist
    field :artists, resolver: Queries::Artists
    field :album,   resolver: Queries::Album
    field :albums,  resolver: Queries::Albums
    field :tracks,  resolver: Queries::Tracks
  end
end
