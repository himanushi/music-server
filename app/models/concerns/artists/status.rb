module Artists
  module Status
    extend ActiveSupport::Concern

    included do
      before_update :sync_status_artists
    end

    def sync_status_artists
      ActiveRecord::Base.transaction do
        apple_music_artists.map {|a| a.__send__("#{status}!") }
        spotify_artists.map {|a| a.__send__("#{status}!") }
        albums.map {|a| a.__send__("#{status}!") }
      end
    end
  end
end