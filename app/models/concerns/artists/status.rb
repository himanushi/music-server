module Artists
  module Status
    extend ActiveSupport::Concern

    def status!(state)
      raise StandardError, "enum に存在しない！" unless self.class.enums(:status).include?(state.to_sym)

      ActiveRecord::Base.transaction do
        albums.map {|album| album.status!(state) }
        __send__("#{state}!")
      end
    end
  end
end
