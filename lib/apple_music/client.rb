module AppleMusic
  class Client
    ENDPOINT = "https://api.music.apple.com"

    attr_reader :locale, :version

    class ResponseError < StandardError
      attr_reader :message
      def initialize(message)
        @message = message
      end
    end

    def initialize(locale: "jp", version: "v1")
      @locale   = locale
      @version  = version
    end

    def client
      @client ||= Faraday::Connection.new(url: ENDPOINT) do |builder|
        builder.use(FaradayMiddleware::ParseJson)
        builder.headers["Content-Type"] = "application/json; charset=utf-8"
        builder.authorization("Bearer", AppleMusic::Token.create[:access_token])
        builder.adapter Faraday.default_adapter
      end
    end

    def catalog_url
      "/#{version}/catalog"
    end

    # @repeat は next を何回実行するか判定する
    def get(url, params = {})
      return {} unless @repeat != 0
      @repeat -= 1 unless @repeat.nil?

      response = client.get(url) do |c|
                   params.each do |k, v|
                     c.params[k] = v
                   end
                 end

      result(response)
    end

    def index(params = {})
      url = "#{catalog_url}/#{locale}/search"
      response = client.get(url) do |c|
                   params.each do |k, v|
                     c.params[k] = v
                   end
                 end

      result(response)
    end

    def get_artist(apple_music_id, params = {})
      begin
        get("#{catalog_url}/#{locale}/artists/#{apple_music_id}", params)
      rescue
        # アーティストを参照できない場合はエラーになる
        # そのためこのメソッドではエラーを回避する
        {}
      end
    end

    def index_artists(name)
      params = {}
      params["term"]  = name
      params["types"] = "artists"
      index(params)
    end

    def get_artist_albums(apple_music_id, params = {})
      begin
        get("#{catalog_url}/#{locale}/artists/#{apple_music_id}/albums", params)
      rescue
        # アーティストのアルバムが存在しない場合はエラーになる
        # そのためこのメソッドではエラーを回避する
        {}
      end
    end

    def get_artist_tracks(apple_music_id, params = {}, repeat: nil)
      @repeat = repeat
      begin
        get("#{catalog_url}/#{locale}/artists/#{apple_music_id}/songs", params)
      rescue
        # アーティストのトラックが存在しない場合はエラーになる
        # そのためこのメソッドではエラーを回避する
        {}
      end
    end

    def get_album(apple_music_id, params = {})
      get("#{catalog_url}/#{locale}/albums/#{apple_music_id}", params)
    end

    def get_track(apple_music_id, params = {})
      get("#{catalog_url}/#{locale}/songs/#{apple_music_id}", params)
    end

    def get_track_by_isrc(isrc)
      get("#{catalog_url}/#{locale}/songs", { "filter[isrc]" => isrc })
    end

    def result(response)
      body = response.body
      if response.success?
        if body["next"].present?
          data = body["data"]
          next_data = get(body["next"])["data"] || []
          { "data" => (data + next_data) }
        else
          body
        end
      else
        raise StandardError, "#{body}, #{response.env.url.to_s}"
      end
    end
  end
end
