class AppleMusicArtist < ApplicationRecord
  table_id :amar

  include AppleMusicCreatable

  belongs_to :artist

  enum status: { pending: 0, active: 1, ignore: 2 }

  class << self
    def mapping(data)
      name   = Artist.to_name(data.dig("attributes", "name"))
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
      apple_music_ids.map {|id| find_or_create_by_apple_music_id(id) }
    end

    def create_by_apple_music_id(apple_music_id)
      data = AppleMusic::Client.new.get_artist(apple_music_id).dig("data", 0)
      return nil unless data.present?
      create_by_data(data)
    end
  end

  def create_albums
    data = AppleMusic::Client.new.get_artist_albums(apple_music_id)["data"]

    return [] unless data.present?

    data.map do |album|
      AppleMusicAlbum.find_or_create_by_apple_music_id(album["id"])
    end.compact
  end
end
