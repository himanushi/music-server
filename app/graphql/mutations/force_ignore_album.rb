class Mutations::ForceIgnoreAlbum < Mutations::BaseMutation
  description "対象アルバムを除外コンテンツに登録する"

  argument :album_id, TTID, required: true, description: "除外コンテンツに登録したいアルバムID"

  field :result, String, null: false

  def mutate(album_id:)
      album = Album.find(album_id)
      album.force_ignore

      Rails.cache.clear
      {
        result: "OK",
      }
  end
end
