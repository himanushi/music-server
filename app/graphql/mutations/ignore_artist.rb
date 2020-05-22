class Mutations::IgnoreArtist < Mutations::BaseMutation
  description "PENDING状態のアーティスト全てをIGNOREにする。よく考えてから実行すること。"

  field :artists, [ArtistType], null: true, description: "IGNOREされたアーティスト"
  field :error, String, null: true

  def mutate
    begin
      artists =
        Artist.where(status: :pending).map do |artist|
          artist.ignore!
          artist
        end

      Rails.cache.clear
      {
        artists: artists,
        error: nil,
      }
    rescue => error
      {
        artists: nil,
        error: error.message,
      }
    end
  end
end
