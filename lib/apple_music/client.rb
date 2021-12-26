# frozen_string_literal: true

require 'net/http'

module AppleMusic
  class Client
    def initialize
      # @type var header: ::Hash[::String, untyped]
      header = {}
      header['authorization'] = "Bearer #{::AppleMusic::Token.create_server_token[:access_token]}"
      @header = header
    end

    def get(url, params = {}, header = @header)
      uri = ::URI.parse(url)
      uri.query = ::URI.encode_www_form(params) unless uri.query
      response = ::Net::HTTP.get_response(uri, header)
      raise(::StandardError, "#{response.code}: #{response.message}") unless response.code.match?(/\A(2|3)/)

      ::JSON.parse(response.body)
    end
  end
end
