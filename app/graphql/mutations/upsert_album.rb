class Mutations::UpsertAlbum < Mutations::BaseMutation
  description "アルバムを最新の状態にする"

  argument :album_ids, [String], required: false, description: "指定したアルバムのトラック(ISRC)を含んでいる別音楽サービスのアルバムを一括登録"
  argument :apple_music_ids, [String], required: false, description: "Apple Music か iTunes のアルバムを登録"
  argument :spotify_ids, [String], required: false, description: "Spotify のアルバムを登録"

  field :albums, [AlbumType], null: true, description: "追加されたアルバムID"
  field :error, String, null: true

  def mutate(album_ids: [], apple_music_ids: [], spotify_ids: [])
    begin
      albums = []

      if album_ids.present?
        album_ids.map do |id|
          albums += Album.find(id).create_all_service_albums
        end
      end

      if apple_music_ids.present?
        apple_music_ids.map do |id|
          albums << AppleMusicAlbum.create_by_apple_music_id(id)&.album
        end
      end

      if spotify_ids.present?
        spotify_ids.map do |id|
          albums << SpotifyAlbum.create_by_spotify_id(id)&.album
        end
      end

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
