class Mutations::CompactAlbum < Mutations::BaseMutation
  description "複数アルバムを単一アルバムに統合する。統合前の複数アルバムは全て IGNORE される。"

  argument :name, String, required: true, description: "統合後のアルバム名。"
  argument :album_ids_for_apple_music, [TTID], required: false, description: "統合したいアルバムID。Apple Music アルバムのみ統合される。指定した順番通りに統合する。"

  field :album, AlbumType, null: true, description: "統合されたアルバム"
  field :error, String, null: true

  def mutate(name:, album_ids_for_apple_music: [])
    begin
      if album_ids_for_apple_music.present?
        ids = album_ids_for_apple_music.map {|id| ::Album.find(id).apple_music_album.id }
        album = ::AppleMusicAlbum.compact(name, ids).album
      end

      Rails.cache.clear
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
