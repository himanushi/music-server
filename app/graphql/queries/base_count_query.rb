module Queries
  class BaseCountQuery < BaseQuery
    attr_reader :conditions

    def query(**args)
      cache_key = args.map {|k, v| [k, v.to_h] }.to_h.to_s + "_count"

      is_cache, result = count_query(**args)

      return result.count unless is_cache

      if Rails.cache.exist?(cache_key)
        Rails.cache.read(cache_key)
      else
        count = result.count
        Rails.cache.write(cache_key, count) if is_cache
        count
      end
    end
  end
end
