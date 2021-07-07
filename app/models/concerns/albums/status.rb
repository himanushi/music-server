module Albums
  module Status
    extend ActiveSupport::Concern

    included do
      before_update :sync_status_albums
    end

    def sync_status_albums
      ActiveRecord::Base.transaction do
        apple_music_and_itunes_album.__send__("#{status}!") if apple_music_and_itunes_album.present?
        tracks.each {|track| track.__send__("#{status}!") }
      end
    end
  end
end
