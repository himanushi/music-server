module Queries
  class SpotifyToken < BaseQuery
    description "Spotify Token"

    type SpotifyTokenType, null: false

    argument :code, String, required: false
    argument :refresh_token, String, required: false

    def query(code: nil, refresh_token: nil)
      result =
        if code.present?
          Spotify::Token.create_client_token(code)
        else
          Spotify::Token.refresh_client_token(refresh_token)
        end

      if result[:access_token].present?
        result
      else
        raise GraphQL::ExecutionError.new(
          "#{result[:error]} : #{result[:error_description]}",
          extensions: { status: 404 }
        )
      end
    end
  end
end
