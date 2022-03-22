# frozen_string_literal: true

module Vgmdb
  class Api
    ENDPOINT_URI = 'https://vgmdb.net/db/calendar.php'

    def parse(url)
      body = ::Vgmdb::Client.new.get(url)
      ::Nokogiri::HTML.parse(body)
    end

    def get_url(time)
      doc = parse("#{ENDPOINT_URI}?year=#{time.year}&month=#{time.month}")
      urls =
        doc.xpath("//*[@id=\"#{time.strftime('%Y%m%d')}\"]/following-sibling::div[1]/div/div/div/a").map do |n|
          n.attributes['href'].value
        rescue ::StandardError
          nil
        end
      urls.compact
    end

    def get_id(url)
      attributes = parse(url).xpath("//a[contains(@href,'music.apple.com')]").first&.attributes
      attributes['href']&.value&.slice(/([0-9]+)$/) if attributes
    end

    def get_ids(time)
      get_url(time).map { |url| get_id(url) }
                   .compact
    end
  end
end
