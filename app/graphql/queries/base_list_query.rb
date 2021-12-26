# frozen_string_literal: true

module Queries
  class BaseListQuery < ::Queries::BaseQuery
    def query(conditions:, sort:, cursor:)
      params = { conditions: conditions, sort: sort, cursor: cursor }
      cache_key = params.transform_values { |v| v.to_h }
                        .to_s

      return ::Rails.cache.read(cache_key) if cache?(conditions: conditions) && ::Rails.cache.exist?(cache_key)

      result = list_query(conditions: conditions)
      relation = order(result, sort: sort, cursor: cursor)

      loaded_result = relation.load
      ::Rails.cache.write(cache_key, loaded_result) if cache?(conditions: conditions)
      loaded_result
    end

    def list_query(conditions:) = query_class.generate_relation(conditions: conditions, context: context)

    def cache?(conditions:) = query_class.cache?(conditions: conditions)

    def order(relation, sort:, cursor:)
      relation.order(
        [
          { sort[:order] => sort[:direction] },
          { id: sort[:direction] }
        ]
      ).distinct.offset(cursor[:offset]).limit(cursor[:limit])
    end
  end
end
