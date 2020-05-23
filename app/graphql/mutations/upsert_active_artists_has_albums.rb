class Mutations::UpsertActiveArtistsHasAlbums < Mutations::BaseMutation
  description "ACTIVE な全てのアーティストの全てのアルバムを最新の状態にする"

  field :artists, [ArtistType], null: true, description: "追加されたアーティスト"
  field :error, String, null: true

  # TODO: cron タスク化
  def mutate
    begin
      artists = Artist.all_create_albums
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
