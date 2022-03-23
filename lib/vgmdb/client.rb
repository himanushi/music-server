# frozen_string_literal: true

require 'net/http'

module Vgmdb
  class Client
    def get(url)
      uri = ::URI.parse(url)
      # @type var header: ::Hash[::String, untyped]
      header = {}
      # Gameカテゴリのみで検索
      header['cookie'] = 'vgm_filter_category_on=1'
      response = ::Net::HTTP.get_response(uri, header)
      unless response.code.match?(/\A(2|3)/)
        raise(::StandardError, "#{response.code}: #{response.message}, URI: #{uri}, Header: #{header}")
      end

      response.body
    end
  end
end
