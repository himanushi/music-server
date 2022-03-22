# frozen_string_literal: true

require 'net/http'

module Vgmdb
  class Client
    def initialize
      # @type var header: ::Hash[::String, untyped]
      # Game カテゴリで検索
      header = { cookie: 'vgm_filter_category_on=1' }
      @header = header
    end

    def get(url, params = {}, header = @header)
      uri = ::URI.parse(url)
      uri.query = ::URI.encode_www_form(params) unless uri.query
      response = ::Net::HTTP.get_response(uri, header)
      unless response.code.match?(/\A(2|3)/)
        raise(::StandardError, "#{response.code}: #{response.message}, URI: #{uri}, Header: #{header}")
      end

      response.body
    end
  end
end
