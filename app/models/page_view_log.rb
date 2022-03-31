# frozen_string_literal: true

class PageViewLog < ::ActiveRecord::Base
  class << self
    def create_yesterday_data
      # 早朝だとまだ昨日のデータは作成されていないため一昨日っぽくなっているがこれでOK
      # @type var yesterday: ::Time
      yesterday = ::Time.now.beginning_of_day - 2.day

      ::ActiveRecord::Base.transaction do
        ::Ggl::BigQuery.get_page_views(yesterday).each do |result|
          attrs = { page_location: result[:page_location], count: result[:count], target_date: yesterday }
          create!(**attrs)
        end
      end
    end
  end
end
