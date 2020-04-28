module Types
  class QueryType < Types::Objects::BaseObject
    field :artist,  resolver: Queries::Artist
    field :artists, resolver: Queries::Artists
    field :album,   resolver: Queries::Album
    field :albums,  resolver: Queries::Albums
  end
end
