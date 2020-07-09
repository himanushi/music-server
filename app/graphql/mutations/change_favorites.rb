class Mutations::ChangeFavorites < Mutations::BaseMutation
  description "お気に入り一括変更"

  argument :artist_ids, [TTID], required: false, description: "お気に入り変更したいアーティストID"
  argument :album_ids, [TTID], required: false, description: "お気に入り変更したいアルバムID"
  argument :favorite, Boolean, required: true, description: "true の場合は一括でお気に入り登録をする。false 場合は一括で解除する。"

  field :artists, [ArtistType], null: true, description: "一括お気に入り変更したアルバム"
  field :albums, [AlbumType], null: true, description: "一括お気に入り変更したアルバム"
  field :error, String, null: true

  def mutate(artist_ids: [], album_ids: [], favorite:)
    begin
      artists = ::Artist.where(id: artist_ids)
      albums  = ::Album.where(id: album_ids)

      if favorite
        ::Favorite.register(artists + albums, context[:current_info][:user])
      else
        ::Favorite.unregister(artists + albums, context[:current_info][:user])
      end

      {
        artists: artists,
        albums: albums,
        error: nil,
      }
    rescue => error
      {
        artists: nil,
        albums: nil,
        error: error.message,
      }
    end
  end
end
