module Tweet
  class Client
    def default_hash_tag
      "#ゲーム音楽 #vgm"
    end

    def post_artist(artist)
      client.update <<~TWEET
        [アーティスト追加]
        #{artist.name} さんが追加されました。
        #{artist_url(artist.id)}
        ##{artist.name.gsub(/\s|-|\./, '')}
        #{default_hash_tag}
      TWEET
    end

    def post_album(album)
      services = []
      services << "#AppleMusic" if album.apple_music_album.present?
      services << "#iTunes" if album.itunes_album.present?
      services << "#Spotify" if album.spotify_album.present?
      client.update <<~TWEET
        [アルバム追加]
        「#{album.service.name}」が追加されました。
        #{album_url(album.id)}
        #{album.artists.active.names.map {|name| "##{name.gsub(/\s|-|\./, '')}" }.join(' ')}
        #{services.join(' ')}
        #{default_hash_tag}
      TWEET
    end

    def artist_url(artist_id)
      "https://video-game-music.net/artists/#{artist_id}?bi=#{artist_id}"
    end

    def album_url(album_id)
      "https://video-game-music.net/albums/#{album_id}?ai=#{album_id}"
    end

    def client
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
        config.access_token = ENV['TWITTER_ACCESS_TOKEN']
        config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
      end
    end
  end
end
