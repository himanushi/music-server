module Spotify
  class Client
    ENDPOINT = "https://api.spotify.com"

    attr_reader :locale, :version

    class ResponseError < StandardError
      attr_reader :message
      def initialize(message)
        @message = message
      end
    end

    def initialize(locale: "JP", version: "v1")
      @locale   = locale
      @version  = version
    end

    def client
      @client ||= Faraday::Connection.new(url: ENDPOINT) do |builder|
        builder.use(FaradayMiddleware::ParseJson)
        builder.headers["Content-Type"] = "application/json; charset=utf-8"
        builder.headers["Accept-Language"] = "ja,en-US;q=0.9,en;q=0.8"
        builder.authorization("Bearer", Spotify::Token.create[:access_token])
        builder.adapter Faraday.default_adapter
      end
    end

    def default_url
      "/#{version}"
    end

    def default_params
      { market: locale }
    end

    def get(url, params = {})
      response = client.get(url) do |c|
                   params.each do |k, v|
                     c.params[k] = v
                   end
                 end

      result(response)
    end

    def index(params = {})
      url = "#{version}/search"
      params["market"] = locale
      response = client.get(url) do |c|
                   params.each do |k, v|
                     c.params[k] = v
                   end
                 end

      result(response)
    end

    def get_artist(spotify_id, params = default_params)
      get("#{default_url}/artists/#{spotify_id}", params)
    end

    def index_artists(name)
      params = {}
      params["q"]  = name
      params["type"] = "artist"
      index(params)
    end

    def get_artist_albums(spotify_id, params = default_params)
      get("#{default_url}/artists/#{spotify_id}/albums", params)
    end

    def get_album(spotify_id, params = default_params)
      get("#{default_url}/albums/#{spotify_id}", params)
    end

    def get_album_tracks(spotify_id, params = default_params)
      get("#{default_url}/albums/#{spotify_id}/tracks", params)
    end

    def get_track(spotify_id, params = default_params)
      get("#{default_url}/tracks/#{spotify_id}", params)
    end

    def get_track_by_isrc(isrc)
      index({ type: "track", q: "isrc:#{isrc}" })
    end

    def get_tracks(spotify_ids, params = default_params)
      params["ids"] = spotify_ids.join(",")
      get("#{default_url}/tracks", params)
    end

    def result(response)
      body = response.body
      raise StandardError, "#{body}, #{response.env.url.to_s}" unless response.success?

      if body["next"].present?
        items         = body["items"]
        next_items    = get(body["next"].gsub(ENDPOINT, ""))["items"] || []
        body["items"] = items + next_items
        body.except!("next")
      end

      body
    end
  end
end
