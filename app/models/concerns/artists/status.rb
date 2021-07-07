module Artists
  module Status
    extend ActiveSupport::Concern

    included do
      before_update :sync_status_artists
    end

    def sync_status_artists
      ActiveRecord::Base.transaction do
        apple_music_artists.each {|a| a.__send__("#{status}!") }
        albums.each {|a| a.__send__("#{status}!") }
      end
    end
  end
end
