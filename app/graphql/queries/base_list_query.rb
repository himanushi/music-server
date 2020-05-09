module Queries
  class BaseListQuery < BaseQuery
    attr_reader :offset, :limit, :conditions, :sort_type, :order

    def query(**args)
      cache_key = args.map {|k, v| [k, v.to_h] }.to_h.to_s

      cursor     = args[:cursor]&.to_h || {}
      sort       = args[:sort]&.to_h || {}
      @sort_type = sort[:type]
      @order     = sort[:order]
      @limit     = cursor[:limit]
      @offset    = cursor[:offset]

      result = list_query(**args)

      if Rails.cache.exist?(cache_key)
        Rails.cache.read(cache_key)
      else
        loaded_result = result.load
        Rails.cache.write(cache_key, loaded_result)
        loaded_result
      end
    end
  end
end
