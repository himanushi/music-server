# frozen_string_literal: true

require 'google/cloud/bigquery'

module Ggl
  class BigQuery
    class << self
      def client
        key = ::ENV['GOOGLE_BIGQUERY_JSON_KEY']
        if key
          key_hash = ::JSON.parse(::JSON.parse(key))
          creds = ::Google::Cloud::Bigquery::Credentials.new(key_hash)
        end
        ::Google::Cloud::Bigquery.new(credentials: creds)
      end

      def get_page_views(from_date, to_date = nil)
        to = to_date || from_date

        sql = <<~SQL.gsub("\n", ' ')
          SELECT
          (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_location') AS page_location,
          COUNT(1) AS page_views
          FROM
            `#{::ENV['GOOGLE_BIGQUERY_TABLE_NAME']}.events_*`
          WHERE
            _TABLE_SUFFIX BETWEEN '#{from_date.strftime('%Y%m%d')}' and '#{to.strftime('%Y%m%d')}'
            AND event_name = 'page_view'
          GROUP BY 1
          ORDER BY 2 DESC
        SQL

        client.query(sql)
      end

      def update_page_views_yesterday
        get_page_views(::Time.now - 2.day)
      end
    end
  end
end
