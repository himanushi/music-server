class Mutations::IgnoreAlbum < Mutations::BaseMutation
  description "PENDING状態のアルバム全てをIGNOREにする。よく考えてから実行すること。"

  field :albums, [AlbumType], null: true, description: "IGNOREされたアルバム"
  field :error, String, null: true

  def mutate
    begin
      albums = Album.all_pending_to_ignore
      Rails.cache.clear
      {
        albums: albums,
        error: nil,
      }
    rescue => error
      {
        albums: nil,
        error: error.message,
      }
    end
  end
end
