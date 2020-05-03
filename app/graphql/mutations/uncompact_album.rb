class Mutations::UncompactAlbum < Mutations::BaseMutation
  description "統合したアルバムを元に戻す。統合された単一アルバムは削除される。"

  argument :album_id_for_apple_music, TTID, required: false, description: "統合解除したいアルバムID。Apple Music アルバムのみ解除される。"
  argument :album_id_for_spotify, TTID, required: false, description: "統合解除したいアルバムID。Spotify アルバムのみ解除される。"

  field :albums, [AlbumType], null: true, description: "統合解除されたアルバム"
  field :error, String, null: true

  def mutate(album_id_for_apple_music: nil, album_id_for_spotify: nil)
    begin
      if album_id_for_apple_music.present? && album_ids_for_spotify.present?
        raise StandardError, "Apple Music アルバムIDと Spotify アルバムID両方にIDを入れてはいけません！"
      end

      if album_id_for_apple_music.present?
        id = ::Album.find(album_id_for_apple_music).apple_music_album.id
        albums = ::AppleMusicAlbum.uncompact(id).map {|a| a.album }
      elsif album_id_for_spotify.present?
        id = ::Album.find(album_id_for_spotify).spotify_album.id
        albums = ::SpotifyAlbum.uncompact(id).map {|a| a.album }
      end

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
