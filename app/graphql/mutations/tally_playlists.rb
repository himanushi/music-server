class Mutations::TallyPlaylists < Mutations::BaseMutation
  description "全プレイリストの人気を集計する"

  field :result, String, null: true
  field :error, String, null: true

  def mutate
    Playlist.tally_popularity
    {
      result: "ok",
    }
  end
end
