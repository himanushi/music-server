class Mutations::MixAlbum < Mutations::BaseMutation
  description <<~DESC
    アルバムを混合する。
    同じアルバムのはずが各音楽サービスで別のアルバムと認識される場合がある。
    その場合に使用する。曲数が多いアルバムを正とする。
  DESC
  argument :album_ids, [TTID], required: true, description: "混合したいアルバムID"

  field :album, AlbumType, null: true, description: "混合されたアルバム"
  field :error, String, null: true

  def mutate(album_ids:)
    begin
      # 音楽サービス追加で変更
      raise StandardError, "アルバムIDは必ず2件にすること" unless album_ids.size == 2

      album = ::Album.mix(album_ids[0], album_ids[1])

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
