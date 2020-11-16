class Mutations::ChangeFavorites < Mutations::BaseMutation
  description "お気に入り一括変更"

  argument :artist_ids, [TTID], required: false, description: "お気に入り変更したいアーティストID"
  argument :album_ids, [TTID], required: false, description: "お気に入り変更したいアルバムID"
  argument :track_ids, [TTID], required: false, description: "お気に入り変更したいトラックID"
  argument :favorite, Boolean, required: true, description: "true の場合は一括でお気に入り登録をする。false 場合は一括で解除する。"

  field :current_user, CurrentUserType, null: true, description: "更新されたカレントユーザー"
  field :error, String, null: true

  def mutate(artist_ids: [], album_ids: [], track_ids: [], favorite:)
    begin
      artists = ::Artist.where(id: artist_ids)
      albums  = ::Album.where(id: album_ids)
      tracks  = ::Track.where(id: track_ids)

      if favorite
        ::Favorite.register(artists + albums + tracks, context[:current_info][:user])
      else
        ::Favorite.unregister(artists + albums + tracks, context[:current_info][:user])
      end

      {
        current_user: context[:current_info][:user].reload,
        error: nil,
      }
    rescue => error
      {
        current_user: nil,
        error: error.message,
      }
    end
  end
end
