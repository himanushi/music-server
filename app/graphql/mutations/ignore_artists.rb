class Mutations::IgnoreArtists < Mutations::BaseMutation
  description "PENDING状態のアーティスト全てをIGNOREにする。よく考えてから実行すること。"

  field :artists, [ArtistType], null: true, description: "IGNOREされたアーティスト"

  def mutate
    artists = Artist.all_pending_to_ignore
    Rails.cache.clear
    {
      artists: artists,
    }
  end
end
