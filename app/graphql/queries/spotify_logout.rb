module Queries
  class SpotifyLogout < BaseQuery
    description "spotify 関連の cookie を削除する"

    type String, null: false

    argument :code, String, required: false

    SPOTIFY_TOKEN_COOKIE_NAME = "spotifyAccessToken"
    SPOTIFY_REFRESH_TOKEN_COOKIE_NAME = "spotifyRefreshToken"
    SPOTIFY_REFRESH_TOKEN_DUMMY_COOKIE_NAME = "spotifyRefreshTokenDummy"

    def query
      delete_cookie(SPOTIFY_TOKEN_COOKIE_NAME)
      delete_cookie(SPOTIFY_REFRESH_TOKEN_COOKIE_NAME)
      delete_cookie(SPOTIFY_REFRESH_TOKEN_DUMMY_COOKIE_NAME)

      "ok"
    end

    def delete_cookie(name)
      cookie_setting = {
        value: "",
        max_age: 0,
        http_only: true,
        same_site: :lax,
        path: "/",
      }

      if Rails.env.production?
        cookie_setting.merge!({ secure: true })
      end

      context[:current_info][:set_cookies].merge!({
        "#{name}" => cookie_setting
      })
    end
  end
end
