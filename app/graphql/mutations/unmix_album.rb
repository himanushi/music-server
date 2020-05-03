class Mutations::UnmixAlbum < Mutations::BaseMutation
  description "アルバムの混合を解除する。アルバムと曲数に相違がある音楽サービスアルバムを分離する。"
  argument :album_id, TTID, required: true, description: "混合解除したいアルバムID"

  field :albums, [AlbumType], null: true, description: "混合されたアルバム"
  field :error, String, null: true

  def mutate(album_id:)
    begin
      albums = ::Album.unmix(album_id)

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
