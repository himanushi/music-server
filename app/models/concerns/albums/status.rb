module Albums
  module Status
    extend ActiveSupport::Concern

    included do
      before_update :sync_status_albums
    end

    def sync_status_albums
      ActiveRecord::Base.transaction do
        apple_music_and_itunes_album.__send__("#{status}!") if apple_music_and_itunes_album.present?
        spotify_album.__send__("#{status}!") if spotify_album.present?
      end
    end
  end
end
