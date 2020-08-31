module Html
  class Ogp
    class << self
      def generate(id)

        # @type var file: File
        file = File.open("#{Rails.root}/public/index.html")

        # @type var html: Nokogiri::HTML::Document
        html = Nokogiri::HTML.parse(file)

        if !id.nil? && id.start_with?(Album.table_id)

          # @type var album: Album
          album  = Album.find(id)
          header = html.at("head")
          header << build_metatag(header, "website", property: "og:type")
          header << build_metatag(header, "ゲーム音楽", property: "og:site_name")
          header << build_metatag(header, album.to_url, property: "og:url")
          header << build_metatag(header, "#{album.service.name} - ゲーム音楽", property: "og:title")
          header << build_metatag(header, "「#{album.service.name}」の発売日は#{album.release_date.strftime('%Y年%m月%d日')}です。収録曲数は#{album.total_tracks}曲です。", property: "og:description")
          header << build_metatag(header, album.service.artwork_l.url, property: "og:image")
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
