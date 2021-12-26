# frozen_string_literal: true

module Mutations
  class ClearCache < ::Mutations::BaseMutation
    description '検索結果キャッシュをリセットする'

    field :result, [::String], null: true

    def mutate
      size = ::File::Stat.new(::Rails.root.join('tmp', 'cache')).size.to_s

      {
        result: [size, *::Rails.cache.clear]
      }
    end
  end
end
