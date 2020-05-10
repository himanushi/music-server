class Mutations::ClearCache < Mutations::BaseMutation
  description "検索結果キャッシュをリセットする"

  field :results, [String], null: true
  field :error, String, null: true

  def mutate
    begin
      size = File::Stat.new(Rails.root.join("tmp", "cache")).size.to_s(:human_size, locale: :en)

      {
        results: [size, *Rails.cache.clear],
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
