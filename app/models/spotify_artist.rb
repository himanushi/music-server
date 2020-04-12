class SpotifyArtist < ApplicationRecord
  table_id :spar

  include SpotifyCreatable
  include SpotifyArtworkResizable

  belongs_to :artist

  enum status: { pending: 0, active: 1, ignore: 2 }

  class << self
    def mapping(data)
      name   = Artist.to_name(data["name"])
      artist = Artist.create_or_find_by(name: name)
      images = data["images"][-3..-1] || []

      {
        artist_id:        artist.id,
        spotify_id:       data["id"],
        name:             name,
        total_followers:  data.dig("followers", "total") || 0,
        artwork_l_url:    images.dig(0, "url"),
        artwork_l_width:  images.dig(0, "width"),
        artwork_l_height: images.dig(0, "height"),
        artwork_m_url:    images.dig(1, "url"),
        artwork_m_width:  images.dig(1, "width"),
        artwork_m_height: images.dig(1, "height"),
        artwork_s_url:    images.dig(2, "url"),
        artwork_s_width:  images.dig(2, "width"),
        artwork_s_height: images.dig(2, "height"),
        popularity:       data["popularity"] || 0,
      }
    end

    def create_by_name(name)
      artists = Spotify::Client.new.index_artists(name).dig("artists", "items") || []
      spotify_ids = artists.map {|artist| artist["id"] }
      spotify_ids.map {|id| find_or_create_by_spotify_id(id) }
    end

    def create_by_spotify_id(spotify_id)
      data = Spotify::Client.new.get_artist(spotify_id)
      return nil unless data["id"].present?
      create_by_data(data)
    end
  end

  def create_albums
    result = Spotify::Client.new.get_artist_albums(spotify_id)

    return [] unless result["items"].present?

    result["items"].map do |album|
      SpotifyAlbum.find_or_create_by_spotify_id(album["id"])
    end.compact
  end
end
