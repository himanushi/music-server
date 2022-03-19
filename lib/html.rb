# frozen_string_literal: true

module Html
  class Ogp
    class << self
      def convert(path)
        # @type var raw_html: String
        raw_html = ::File.open("#{::Rails.root}/public/index-dummy.html")&.read || ''

        # @type var id: String?
        _, id = (path || '').split('/')

        # @type var html: Nokogiri::HTML::Document
        html = ::Nokogiri::HTML.parse(raw_html)

        # @type var web_name: String
        web_name = 'ゲーム音楽'
        html.title = web_name

        # @type ver header: Nokogiri::XML::Node
        header = html.at('head')
        header << build_metatag(header, '音楽サブスクリプション配信中のゲーム音楽のポータルサイト', name: 'description')

        # 環境変数
        add_env(header) if ::Rails.env.production?

        if id && id.start_with?(::Album.new.table_id)
          album = ::Album.find(id)
          if (service = album.service)
            header << build_metatag(header, 'website', property: 'og:type')
            header << build_metatag(header, web_name, property: 'og:site_name')
            header << build_metatag(header, album.to_url, property: 'og:url')
            header << build_metatag(header, "#{service.name} - #{web_name}", property: 'og:title')
            header << build_metatag(
              header,
              "「#{service.name}」の発売日は#{album.release_date.strftime('%Y年%m月%d日')}です。収録曲数は#{album.total_tracks}曲です。",
              property: 'og:description'
            )
            header << build_metatag(header, service.artwork_l.url, property: 'og:image') if service.artwork_l.url
            header << build_metatag(header, 'summary', name: 'twitter:card')
            header << build_metatag(header, '@vgm_net', name: 'twitter:site')
          end
        end

        if id && id.start_with?(::Playlist.new.table_id)
          playlist = ::Playlist.find(id)
          header << build_metatag(header, 'website', property: 'og:type')
          header << build_metatag(header, web_name, property: 'og:site_name')
          header << build_metatag(header, playlist.to_url, property: 'og:url')
          header << build_metatag(header, "#{playlist.name} - #{web_name}", property: 'og:title')
          description = playlist.description
          header << build_metatag(header, description, property: 'og:description') if description
          url = playlist.track.service&.artwork_l&.url
          header << build_metatag(header, url, property: 'og:image') if url
          header << build_metatag(header, 'summary', name: 'twitter:card')
          header << build_metatag(header, '@vgm_net', name: 'twitter:site')
        end

        html.to_s
      end

      def build_metatag(header, content, **prop)
        og = ::Nokogiri::XML::Node.new('meta', header)
        prop.each do |key, value|
          og[key.to_s] = value
        end
        og['content'] = content
        og
      end

      def add_env(header)
        app_url = ::ENV['PRODUCTION_APP_URL']
        if app_url
          header.first_element_child.before(build_metatag(header, app_url.to_s, property: 'ms:origin-url'))
          header.first_element_child.before(build_metatag(header, "#{app_url}/graphql", property: 'ms:graphql-url'))
        end

        recaptcha_client_key = ::ENV['GOOGLE_RECAPTCHA_V2_CLIENT_KEY']
        if recaptcha_client_key
          header.first_element_child.before(
            build_metatag(
              header,
              recaptcha_client_key,
              property: 'ms:recaptcha-key'
            )
          )
        end

        google_analytics_id = ::ENV['GOOGLE_ANALYTICS_ID']
        if google_analytics_id
          header.first_element_child.before(
            build_metatag(
              header,
              google_analytics_id,
              property: 'ms:google-analytics-id'
            )
          )
        end

        apple_affiliate_token = ::ENV['APPLE_AFFILIATE_TOKEN']
        if apple_affiliate_token
          header.first_element_child.before(
            build_metatag(
              header,
              apple_affiliate_token,
              property: 'ms:apple-affiliate-token'
            )
          )
        end

        twitter_account = ::ENV['TWITTER_ACCOUNT']
        if twitter_account
          header.first_element_child.before(build_metatag(header, twitter_account, property: 'ms:twitter-account'))
        end

        header
      end
    end
  end
end
