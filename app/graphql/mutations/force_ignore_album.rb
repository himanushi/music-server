class Mutations::ForceIgnoreAlbum < Mutations::BaseMutation
  description "対象アルバムを除外コンテンツに登録する"

  argument :album_id, TTID, required: true, description: "除外コンテンツに登録したいアルバムID"

  field :album, AlbumType, null: true, description: "除外コンテンツに登録されたアルバム"
  field :error, String, null: true

  def mutate(album_id:)
    begin
      album = Album.find(album_id)
      album.force_ignore

      Rails.cache.clear
      {
        result: "削除しました",
        error: nil,
      }
    rescue => error
      {
        result: nil,
        error: error.message,
      }
    end
  end
end
