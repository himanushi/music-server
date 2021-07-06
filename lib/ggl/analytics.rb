# ref: https://developers.google.com/analytics/devguides/reporting/core/v4/rest/v4/reports/batchGet

module Ggl
  class Analytics
    class << self
      def analytics
        Google::Apis::AnalyticsreportingV4
      end

      def client
        scope = ['https://www.googleapis.com/auth/analytics.readonly']
        client = analytics::AnalyticsReportingService.new
        client.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
          json_key_io: File.open('tmp/key/google-auth-cred.json'),
          scope: scope
        )

        client
      end

      def pv_report(start_date:, end_date: 'today', next_page_token: "0", filter: [])
        view_id = ENV['GOOGLE_ANALYTICS_VIEW_ID']
        date_range = analytics::DateRange.new(start_date: start_date, end_date: end_date)
        metric = analytics::Metric.new(expression: 'ga:pageviews', alias: 'pv')
        dimension = analytics::Dimension.new(name: 'ga:pagePath')
        order_by = analytics::OrderBy.new(field_name: 'ga:pageviews', sort_order: 'DESCENDING')

        request = analytics::GetReportsRequest.new(
          report_requests: [analytics::ReportRequest.new(
            view_id: view_id,
            metrics: [metric],
            dimensions: [dimension],
            metric_filter_clauses: filter,
            date_ranges: [date_range],
            order_bys: [order_by],
            page_token: next_page_token
          )]
        )
        response = client.batch_get_reports(request)

        result = response.reports[0].to_h
        rows = result[:data][:rows]

        if result[:next_page_token]
          rows = rows.concat(pv_report(
            start_date: start_date,
            end_date: end_date,
            next_page_token: result[:next_page_token],
            filter: filter
          ))
        end

        rows
      end

      def all
        # 全件はデータ量が多すぎるのでフィルタリングする
        # filter = [analytics::MetricFilterClause.new(
        #   filters: [analytics::MetricFilter.new(
        #     metric_name: "ga:pageviews",
        #     comparison_value: "2",
        #     operator: "GREATER_THAN"
        #   )]
        # )]
        filter = []
        pv_report(start_date: '2020-07-15', filter: filter)
      end

      def reset_all
        update(all)
      end

      # row = {:dimensions=>["/albums/abm1755be28b675c?ai=abm1755be28b675c"], :metrics=>[{:values=>["851"]}]}
      def update(rows)
        results = {
          artists: Hash.new(0),
          albums: Hash.new(0),
          tracks: Hash.new(0),
          playlist: Hash.new(0),
        }

        rows.each do |row|
          path = row[:dimensions].first

          results.keys.each do |key|
            if m = path.gsub(/\?.*/, "").match(/\/#{key}\/(?<id>.*)/)
              id = m[:id]
              pv = row[:metrics].first[:values].first.to_i
              results[key][id] += pv
            end
          end
        end

        ActiveRecord::Base.transaction do
          results.keys.each do |table_name|
            t2 = results[table_name].map{|id, pv| "select '#{id}' as id, '#{pv}' as pv" }.join(" union all ")
            ActiveRecord::Base.connection.execute(<<~SQL)
              UPDATE
              #{table_name.to_s.pluralize} t1,
              (
                #{t2}
              ) t2
              SET
              t1.pv = t2.pv
              WHERE
              t1.id = t2.id
            SQL
          end
        end
      end
    end
  end
end
