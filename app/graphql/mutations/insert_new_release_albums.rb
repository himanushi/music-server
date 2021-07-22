class Mutations::InsertNewReleaseAlbums < Mutations::BaseMutation
  description "新着アルバムを追加する"

  field :albums, [AlbumType], null: true
  field :error, String, null: true

  def mutate
    albums = Album.create_by_new_releases

    {
      albums: albums,
      error: nil,
    }
  end
end
