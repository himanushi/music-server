module Queries
  class SpotifyLogin < BaseQuery
    description "Spotify Login"

    type String, null: false

    argument :code, String, required: false

    # refresh token はセキュアに保持するため js で触れる cookie を dummy とし有効期限を設ける
    SPOTIFY_TOKEN_COOKIE_NAME = "spotifyAccessToken"
    SPOTIFY_REFRESH_TOKEN_COOKIE_NAME = "spotifyRefreshToken"
    SPOTIFY_REFRESH_TOKEN_DUMMY_COOKIE_NAME = "spotifyRefreshTokenDummy"

    def query(code: nil)
      result =
        if code.present?
          Spotify::Token.create_client_token(code)
        else
          Spotify::Token.refresh_client_token(context[:current_info][:cookie][SPOTIFY_REFRESH_TOKEN_COOKIE_NAME])
        end

      if result[:access_token].present?
        set_cookie(result)
        "ok"
      else
        raise GraphQL::ExecutionError.new(
          "#{result[:error]} : #{result[:error_description]}",
          extensions: { status: 404 }
        )
      end
    end

    def set_cookie(result)
      cookie_setting = {
        value: result[:access_token],
        max_age: result[:expires_in],
        path: "/",
      }

      if Rails.env.production?
        cookie_setting.merge!({ secure: true })
      end

      context[:current_info][:set_cookies].merge!({
        "#{SPOTIFY_TOKEN_COOKIE_NAME}" => cookie_setting
      })

      if result[:refresh_token]
        max_age = 30.days.to_i

        cookie_setting = {
          value: result[:refresh_token],
          max_age: max_age,
          http_only: true,
          same_site: :lax,
          path: "/",
        }

        if Rails.env.production?
          cookie_setting.merge!({ secure: true })
        end

        context[:current_info][:set_cookies].merge!({
          "#{SPOTIFY_REFRESH_TOKEN_COOKIE_NAME}" => cookie_setting
        })

        cookie_setting = {
          value: "dummy",
          max_age: max_age,
          same_site: :lax,
          path: "/",
        }

        if Rails.env.production?
          cookie_setting.merge!({ secure: true })
        end

        context[:current_info][:set_cookies].merge!({
          "#{SPOTIFY_REFRESH_TOKEN_DUMMY_COOKIE_NAME}" => cookie_setting
        })
      end
    end
  end
end
