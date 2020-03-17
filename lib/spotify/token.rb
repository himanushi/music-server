module Spotify
  class Token
    def self.create
      secret_token = Base64.encode64("#{ENV['SPOTIFY_CLIENT_ID']}:#{ENV['SPOTIFY_CLIENT_SECRET']}").gsub(/\n/,"")

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
  end
end
