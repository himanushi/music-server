module Types
  class QueryType < Types::Objects::BaseObject
    field :artists, resolver: Queries::ArtistsQuery
    field :album,   resolver: Queries::AlbumQuery
    field :albums,  resolver: Queries::AlbumsQuery
  end
end
