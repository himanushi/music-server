# frozen_string_literal: true

module AppleMusic
  class Api
    ENDPOINT = 'https://api.music.apple.com'
    public_constant :ENDPOINT

    RSS_ENDPOINT = 'https://rss.applemarketingtools.com/api/v2'
    public_constant :RSS_ENDPOINT

    LOCALE = 'jp'
    public_constant :LOCALE

    DEFAULT_REPEAT = 5
    public_constant :DEFAULT_REPEAT

    ALL_GENRES = {
      '4': 'チルドレン・ミュージック',
      '5': 'クラシック',
      '7': 'エレクトロニック',
      '11': 'ジャズ',
      '14': 'ポップ',
      '15': 'R&B／ソウル',
      '16': 'サウンドトラック',
      '17': 'ダンス',
      '18': 'ヒップホップ／ラップ',
      '20': 'オルタナティブ',
      '21': 'ロック',
      '24': 'レゲエ',
      '27': 'J-Pop',
      '28': '演歌',
      '29': 'アニメ',
      '30': '歌謡曲',
      '34': 'ミュージック',
      '51': 'K-Pop'
    }.freeze
    public_constant :ALL_GENRES

    class << self
      def apple_music_most_played
        ::AppleMusic::Client.new.get(
          "#{::AppleMusic::Api::RSS_ENDPOINT}/#{::AppleMusic::Api::LOCALE}/music/most-played/200/albums.json", {}, {}
        )
      end
    end

    def initialize
      @client = ::AppleMusic::Client.new
      @locale = ::AppleMusic::Api::LOCALE
      @repeat = ::AppleMusic::Api::DEFAULT_REPEAT
    end

    def get(url, params = nil)
      return {} unless @repeat.positive?

      @repeat -= 1

      # @type var body: ::Hash[::String, untyped]
      body = @client.get(::AppleMusic::Api::ENDPOINT + url, params || {})
      compound(body)
    end

    def get_artist(apple_music_id)
      get("#{catalog_url}/artists/#{apple_music_id}")
    rescue ::StandardError
      # アーティストを参照できない場合がある
      {}
    end

    def get_artist_albums(apple_music_id, repeat = nil)
      @repeat = repeat if repeat
      get("#{catalog_url}/artists/#{apple_music_id}/albums")
    rescue ::StandardError
      # アーティストを参照できない場合がある
      {}
    end

    def get_artist_tracks(apple_music_id, repeat = nil)
      @repeat = repeat if repeat
      get("#{catalog_url}/artists/#{apple_music_id}/songs")
    rescue ::StandardError
      # アーティストを参照できない場合がある
      {}
    end

    def get_album(apple_music_id)
      # @type var params: ::Hash[::String, untyped]
      params = {}
      params['include'] = 'artists'
      get("#{catalog_url}/albums/#{apple_music_id}", params)
    end

    def get_track(apple_music_id)
      # @type var params: ::Hash[::String, untyped]
      params = {}
      params['include'] = 'artists'
      get("#{catalog_url}/songs/#{apple_music_id}", params)
    end

    def get_track_by_isrc(isrc)
      # @type var params: ::Hash[::String, untyped]
      params = {}
      params['filter[isrc]'] = isrc
      get("#{catalog_url}/songs", params)
    end

    def get_chart_albums(genre, limit)
      # @type var params: ::Hash[::String, untyped]
      params = {}
      params['types'] = 'albums'
      params['genre'] = genre
      params['limit'] = limit
      get("#{catalog_url}/charts", params)
    end

    def get_chart_tracks(genre, limit)
      # @type var params: ::Hash[::String, untyped]
      params = {}
      params['types'] = 'songs'
      params['genre'] = genre
      params['limit'] = limit
      get("#{catalog_url}/charts", params)
    end

    def get_genre(id)
      get("#{catalog_url}/genres/#{id}")
    end

    private

    def compound(body)
      if body['next']
        data = body['data']
        next_data = get(body['next'])['data'] || []
        # @type var result: ::Hash[::String, untyped]
        result = {}
        result['data'] = data + next_data
        result
      else
        body
      end
    end

    def catalog_url
      "/v1/catalog/#{@locale}"
    end
  end
end
