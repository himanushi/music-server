module Albums
  module Status
    extend ActiveSupport::Concern

    def status!(state)
      raise StandardError, "enum に存在しない！" unless self.class.enums(:status).include?(state.to_sym)

      ActiveRecord::Base.transaction do
        apple_music_and_itunes_album.__send__("#{state}!") if apple_music_and_itunes_album.present?
        spotify_album.__send__("#{state}!") if spotify_album.present?
        __send__("#{state}!")
      end
    end
  end
end
