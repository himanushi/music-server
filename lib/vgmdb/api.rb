# frozen_string_literal: true

module Vgmdb
  class Api
    ENDPOINT_URI = 'https://vgmdb.net/db/calendar.php'
    public_constant :ENDPOINT_URI

    def parse(url)
      body = ::Vgmdb::Client.new.get(url)
      ::Nokogiri::HTML.parse(body)
    end

    def get_url(time)
      doc = parse("#{::Vgmdb::Api::ENDPOINT_URI}?year=#{time.year}&month=#{time.month}")
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
      # @type var results: ::Array[::String]
      results = []

      get_url(time).each do |url|
        id = get_id(url)
        results << id if id
      end

      results
    end
  end
end
