class Mutations::GenerateSitemaps < Mutations::BaseMutation
  description "サイトマップを更新する"

  field :results, [String], null: true
  field :error, String, null: true

  def mutate
    begin
      file_names = SitemapGenerator.generate_all

      {
        results: file_names,
        error: nil,
      }
    rescue => error
      {
        results: nil,
        error: error.message,
      }
    end
  end
end
