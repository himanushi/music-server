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
          attrs = { page_location: result[:page_location], count: result[:count], target_date: target_date }
          create!(**attrs)
        end
      end
    end
  end
end
