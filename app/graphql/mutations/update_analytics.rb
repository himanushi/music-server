class Mutations::UpdateAnalytics < Mutations::BaseMutation
  description "Google Analytics で PV 数を再計算"

  field :result, String, null: true
  field :error, String, null: true

  def mutate
    Ggl::Analytics.reset_all
    {
      result: "ok",
    }
  end
end
