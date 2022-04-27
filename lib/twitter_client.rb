# frozen_string_literal: true

class TwitterClient
  class << self
    def default_hash_tag
      '#ゲーム音楽 #vgm'
    end

    def post_album(album)
      # @type var services: ::Array[::String]
      services = []
      services << if album.apple_music_album&.playable
                    '#AppleMusic'
                  else
                    '#iTunes'
                  end
      tweet = <<~TWEET
        [アルバム追加]
        「#{album.service&.name}」が追加されました。
        #{album.to_url}
        #{default_hash_tag}
        #{services.join(' ')}
        #{album.composers.map { |c| "##{c.name.gsub(/\s|-|\.|:/, '')}" }
        .join(' ')}
      TWEET
      client.update(tweet[..139] || '')
    end

    def client
      # steep skip
      __skip__ =
        @client =
          ::Twitter::REST::Client.new do |config|
            config.consumer_key = ::ENV['TWITTER_CONSUMER_KEY']
            config.consumer_secret = ::ENV['TWITTER_CONSUMER_SECRET']
            config.access_token = ::ENV['TWITTER_ACCESS_TOKEN']
            config.access_token_secret = ::ENV['TWITTER_ACCESS_TOKEN_SECRET']
          end
    end
  end
end
