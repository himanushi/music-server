class Mutations::UpsertAlbum < Mutations::BaseMutation
  description "アルバムを最新の状態にする"

  argument :album_id, TTID, required: false, description: "指定したアルバムのトラック(ISRC)を含んでいる別音楽サービスのアルバムを一括登録"
  argument :apple_music_id, String, required: false, description: "Apple Music か iTunes のアルバムを登録"

  field :albums, [AlbumType], null: true, description: "追加されたアルバム"
  field :error, String, null: true

  def mutate(album_id: nil, apple_music_id: nil)
    begin
      albums = []

      if album_id.present?
        albums += Album.find(album_id).create_all_service_albums
      end

      if apple_music_id.present?
        albums << AppleMusicAlbum.create_by_music_service_id(apple_music_id)&.album
      end

      albums = albums.compact.uniq.map {|a| a.reload }

      Rails.cache.clear
      {
        albums: albums.compact.uniq,
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
