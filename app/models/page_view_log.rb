# frozen_string_literal: true

class PageViewLog < ::ActiveRecord::Base
  class << self
    def create_yesterday_data
      # 早朝だとまだ昨日のデータは作成されていないため一昨日っぽくなっているがこれでOK
      # @type var yesterday: ::Time
      yesterday = ::Time.now.beginning_of_day - 2.day
      create_from_big_query(yesterday)
    end

    def create_from_big_query(target_date)
      return unless ::PageViewLog.where(target_date: target_date).empty?

      ::ActiveRecord::Base.transaction do
        ::Ggl::BigQuery.get_page_views(target_date).each do |result|
          page_location = result[:page_location].gsub(/\?.*/, '').gsub(%r{https?://.*?/}, '/')[..254]
          attrs = { page_location: page_location, count: result[:count], target_date: target_date }
          create!(**attrs)
        end
      end
    end

    def update_page_view_colmuns
      results = { artists: ::Hash.new(0), albums: ::Hash.new(0), tracks: ::Hash.new(0), playlist: ::Hash.new(0) }

      ::PageViewLog.all.each do |pv|
        results.each_key do |key|
          next unless (match = pv.page_location.match(%r{/#{key}/(?<id>.*)}))

          id = match[:id]
          results[key][id] += pv.count
        end
      end

      ::ActiveRecord::Base.transaction do
        results.each_key do |table_name|
          next unless results[table_name].present?

          t2 = results[table_name].map { |id, pv| "select '#{id}' as id, '#{pv}' as pv" }
                                  .join(' union all ')
          ::ActiveRecord::Base.connection.execute(<<~SQL)
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
