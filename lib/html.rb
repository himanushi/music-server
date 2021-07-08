module Html
  class Ogp
    class << self
      def convert(path)

        # @type var raw_html: String
        raw_html = File.open("#{Rails.root}/public/index-dummy.html")&.read || ""

        # @type var category: String?
        # @type var id: String?
        category, id = (path || "").split("/")

        # @type var html: Nokogiri::HTML::Document
        html = Nokogiri::HTML.parse(raw_html)

        # @type var web_name: String
        web_name = "ゲーム音楽"
        html.title = web_name

        # @type ver header: Nokogiri::XML::Element
        header = html.at("head")
        header << build_metatag(header, "音楽サブスクリプション配信中のゲーム音楽のポータルサイト", name: "description")

        # 環境変数
        if Rails.env.production?
          header.first_element_child.before build_metatag(header, "#{ENV['PRODUCTION_APP_URL']}/graphql", property: "ms:graphql-url") if ENV['PRODUCTION_APP_URL']
          header.first_element_child.before build_metatag(header, ENV['GOOGLE_RECAPTCHA_V2_CLIENT_KEY'], property: "ms:recaptcha-key") if ENV['GOOGLE_RECAPTCHA_V2_CLIENT_KEY']
          header.first_element_child.before build_metatag(header, ENV['GOOGLE_ANALYTICS_ID'], property: "ms:google-analytics-id") if ENV['GOOGLE_ANALYTICS_ID']
          header.first_element_child.before build_metatag(header, ENV['APPLE_AFFILIATE_TOKEN'], property: "ms:apple-affiliate-token") if ENV['APPLE_AFFILIATE_TOKEN']
          header.first_element_child.before build_metatag(header, ENV['TWITTER_ACCOUNT'], property: "ms:twitter-account") if ENV['TWITTER_ACCOUNT']
        end

        if !id.nil? && id&.start_with?(Album.table_id)

          # @type var id: String
          # @type var album: Album
          album  = Album.find(id)

          header << build_metatag(header, "website", property: "og:type")
          header << build_metatag(header, web_name, property: "og:site_name")
          header << build_metatag(header, album.to_url, property: "og:url")
          header << build_metatag(header, "#{album.service.name} - #{web_name}", property: "og:title")
          header << build_metatag(header, "「#{album.service.name}」の発売日は#{album.release_date.strftime('%Y年%m月%d日')}です。収録曲数は#{album.total_tracks}曲です。", property: "og:description")
          header << build_metatag(header, album.service.artwork_l.url, property: "og:image")
          header << build_metatag(header, "summary", name: "twitter:card")
          header << build_metatag(header, "@vgm_net", name: "twitter:site")
        end

        if !id.nil? && id&.start_with?(Playlist.table_id)

          # @type var id: String
          # @type var playlist: Playlist
          playlist  = Playlist.find(id)

          header << build_metatag(header, "website", property: "og:type")
          header << build_metatag(header, web_name, property: "og:site_name")
          header << build_metatag(header, playlist.to_url, property: "og:url")
          header << build_metatag(header, "#{playlist.name} - #{web_name}", property: "og:title")
          if playlist.description.present?
            header << build_metatag(header, playlist.description, property: "og:description")
          end
          if playlist.track.present?
            header << build_metatag(header, playlist.track.service.artwork_l.url, property: "og:image")
          end
          header << build_metatag(header, "summary", name: "twitter:card")
          header << build_metatag(header, "@vgm_net", name: "twitter:site")
        end

        html.to_s
      end

      def build_metatag(header, content, **prop)
        og = Nokogiri::XML::Node.new("meta", header)
        prop.each do |key, value|
          og[key.to_s] = value
        end
        og["content"]  = content
        og
      end
    end
  end
end
