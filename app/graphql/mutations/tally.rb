class Mutations::Tally < Mutations::BaseMutation
  description "人気を集計する"

  field :result, String, null: true
  field :error, String, null: true

  def mutate
    Popularity.tally
    {
      result: "ok",
    }
  end
end
