module Spotify
  class Token
    def self.create_server_token
      secret_token = Base64.encode64("#{ENV['SPOTIFY_SERVER_ID']}:#{ENV['SPOTIFY_SERVER_SECRET']}").gsub(/\n/,"")

      result = Faraday.post("https://accounts.spotify.com/api/token") do |req|
        req.headers['Authorization'] = "Basic #{secret_token}"
        req.body = { grant_type: "client_credentials" }
      end

      # response
      #
      # {
      #   access_token: "AAAAAAA...",
      #   token_type:   "Bearer",
      #   expires_in:   3600,
      #   scope:        "",
      # }
      JSON.parse(result.body).symbolize_keys
    end

    def self.create_client_token(code)
      secret_token = Base64.encode64("#{ENV['SPOTIFY_CLIENT_ID']}:#{ENV['SPOTIFY_CLIENT_SECRET']}").gsub(/\n/,"")

      # ref: https://github.com/spotify/web-api-auth-examples/blob/master/authorization_code/app.js#L76
      result = Faraday.post("https://accounts.spotify.com/api/token") do |req|
        req.headers['Authorization'] = "Basic #{secret_token}"
        req.body = {
          code: code,
          redirect_uri: Rails.env.production? ? ENV['SPOTIFY_REDIRECT_URI'] : "http://localhost:3001/me",
          grant_type: "authorization_code",
        }
      end

      # response
      #
      # {
      #   access_token: "AAAAAAA...",
      #   token_type:   "Bearer",
      #   expires_in:   3600,
      #   scope:        "",
      # }
      JSON.parse(result.body).symbolize_keys
    end

    def self.refresh_client_token(refresh_token)
      secret_token = Base64.encode64("#{ENV['SPOTIFY_CLIENT_ID']}:#{ENV['SPOTIFY_CLIENT_SECRET']}").gsub(/\n/,"")

      # ref: https://github.com/spotify/web-api-auth-examples/blob/master/authorization_code/app.js#L76
      result = Faraday.post("https://accounts.spotify.com/api/token") do |req|
        req.headers['Authorization'] = "Basic #{secret_token}"
        req.body = {
          refresh_token: refresh_token,
          grant_type: 'refresh_token',
        }
      end

      # response
      #
      # {
      #   access_token: "AAAAAAA...",
      #   token_type:   "Bearer",
      #   expires_in:   3600,
      #   scope:        "",
      # }
      JSON.parse(result.body).symbolize_keys
    end
  end
end
