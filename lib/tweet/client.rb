module Tweet
  class Client
    def default_hash_tag
      "#ゲーム音楽 #vgm"
    end

    def post_artist(artist)
      client.update <<~TWEET
        [アーティスト追加]
        #{artist.name} さんが追加されました。
        #{artist.to_url}
        ##{artist.name.gsub(/\s|-|\./, '')}
        #{default_hash_tag}
      TWEET
    end

    def post_album(album)
      services = []
      services << "#AppleMusic" if album.apple_music_album.present?
      services << "#iTunes" if album.itunes_album.present?
      client.update <<~TWEET
        [アルバム追加]
        「#{album.service.name}」が追加されました。
        #{album.to_url}
        #{album.composers.map {|c| "##{c.name.gsub(/\s|-|\./, '')}" }.join(' ')}
        #{services.join(' ')}
        #{default_hash_tag}
      TWEET
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
