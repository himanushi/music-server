module Types
  class QueryType < Types::Objects::BaseObject
    field :album,  resolver: Queries::AlbumQuery
    field :albums, resolver: Queries::AlbumsQuery
  end
end
