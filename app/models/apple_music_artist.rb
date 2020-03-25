class AppleMusicArtist < ApplicationRecord
  table_id :amar

  include AppleMusicCreatable

  belongs_to :artist

  enum status: { pending: 0, active: 1, ignore: 2 }

  class << self
    def mapping(data)
      name   = data.dig("attributes", "name").gsub(/\s|　/, "")
      artist = Artist.find_or_create_by(name: name)

      {
        artist_id:      artist.id,
        apple_music_id: data["id"],
        name:           name,
      }
    end

    def create_by_name(name)
      artists = AppleMusic::Client.new.index_artists(name).dig("results", "artists", "data") || []
      apple_music_ids = artists.map {|artist| artist["id"] }
      apple_music_ids.map {|id| create_by_apple_music_id(id).first }
    end
  end
end
