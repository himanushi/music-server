class Mutations::CompactAlbum < Mutations::BaseMutation
  description "複数アルバムを単一アルバムに統合する。統合前の複数アルバムは全て IGNORE される。"

  argument :name, String, required: true, description: "統合後のアルバム名。"
  argument :album_ids_for_apple_music, [TTID], required: false, description: "統合したいアルバムID。Apple Music アルバムのみ統合される。指定した順番通りに統合する。"
  argument :album_ids_for_spotify, [TTID], required: false, description: "統合したいアルバムID。Spotify アルバムのみ統合される。指定した順番通りに統合する。"

  field :album, AlbumType, null: true, description: "統合されたアルバム"
  field :error, String, null: true

  def mutate(name:, album_ids_for_apple_music: [], album_ids_for_spotify: [])
    begin
      if album_ids_for_apple_music.present? && album_ids_for_spotify.present?
        raise StandardError, "Apple Music アルバムIDと Spotify アルバムID両方にIDを入れてはいけません！"
      end

      if album_ids_for_apple_music.present?
        ids = album_ids_for_apple_music.map {|id| ::Album.find(id).apple_music_album.id }
        album = ::AppleMusicAlbum.compact(name, ids).album
      elsif album_ids_for_spotify.present?
        ids = album_ids_for_spotify.map {|id| ::Album.find(id).spotify_album.id }
        album = ::SpotifyAlbum.compact(name, ids).album
      end

      {
        album: album,
        error: nil,
      }
    rescue => error
      {
        album: nil,
        error: error.message,
      }
    end
  end
end
