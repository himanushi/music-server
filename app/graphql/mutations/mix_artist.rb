class Mutations::MixArtist < Mutations::BaseMutation
  description <<~DESC
    アーティストを混合する。
    混合後は修正不可のため注意して使用すること。
  DESC
  argument :main_artist_id, TTID, required: true, description: "メインアーティストID"
  argument :sub_artist_id, TTID, required: true, description: "サブアーティストID"

  field :artist, ArtistType, null: true, description: "混合されたアーティスト"
  field :error, String, null: true

  def mutate(main_artist_id:, sub_artist_id:)
    begin
      artist = ::Artist.mix!(main_artist_id, sub_artist_id)

      Rails.cache.clear
      {
        artist: artist,
        error: nil,
      }
    rescue => error
      {
        artist: nil,
        error: error.message,
      }
    end
  end
end
