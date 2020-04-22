module Types
  class QueryType < Types::Objects::BaseObject
    field :artist,  resolver: Queries::ArtistQuery
    field :artists, resolver: Queries::ArtistsQuery
    field :album,   resolver: Queries::AlbumQuery
    field :albums,  resolver: Queries::AlbumsQuery
  end
end
