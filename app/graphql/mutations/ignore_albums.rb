class Mutations::IgnoreAlbums < Mutations::BaseMutation
  description "PENDING状態のアルバム全てをIGNOREにする。よく考えてから実行すること。"

  field :albums, [AlbumType], null: true, description: "IGNOREされたアルバム"

  def mutate
    albums = Album.all_pending_to_ignore
    Rails.cache.clear
    {
      albums: albums,
    }
  end
end
