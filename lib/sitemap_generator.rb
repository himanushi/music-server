class SitemapGenerator
  class << self
    def generate_all
      file_names = []
      file_names += generate_albums
      file_names += generate_artists
      export_file("sitemap_index.xml", to_index_xml(file_names))

      ["sitemap_index.xml", *file_names]
    end

    def generate_models(klass)
      file_names = []

      index = 0
      klass.active.in_batches(of: 3000) do |records|
        index += 1
        file_name = "sitemap_#{klass.name.downcase}#{index}.xml"
        file_names << file_name
        export_file(file_name, to_xml(records))
      end

      file_names
    end

    def generate_albums
      generate_models(Album)
    end

    def generate_artists
      generate_models(Artist)
    end

    def export_file(file_name, content)
      default_path = "public"

      File.open(File.join(default_path, file_name), "w+") do |f|
        f.write(content)
      end
    end

    def to_xml_content(record)
      <<~XML
        <url>
            <loc>#{record.to_url}</loc>
            <lastmod>#{record.updated_at.strftime('%Y-%m-%d')}</lastmod>
            <changefreq>weekly</changefreq>
        </url>
      XML
    end

    def to_xml(records)
      <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
        #{ records.map {|record| to_xml_content(record) }.join.strip }
        </urlset>
      XML
    end

    def to_index_xml_content(file_name)
      <<~XML
        <sitemap>
            <loc>#{ENV['PRODUCTION_APP_URL']}/#{file_name}</loc>
            <lastmod>#{DateTime.current.strftime('%Y-%m-%d')}</lastmod>
        </sitemap>
      XML
    end

    def to_index_xml(file_names)
      <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
        #{ file_names.map {|file_name| to_index_xml_content(file_name) }.join.strip }
        </sitemapindex>
      XML
    end
  end
end
