class SpotifyArtist < ApplicationRecord
  table_id :spar

  include SpotifyCreatable

  belongs_to :artist

  enum status: { pending: 0, active: 1, ignore: 2 }

  class << self
    def mapping(data)
      name   = data["name"].gsub(/\s|　/, "")
      artist = Artist.create_or_find_by(name: name)
      images = data["images"][-3..-1] || []

      {
        artist_id:        artist.id,
        spotify_id:       data["id"],
        name:             name,
        total_followers:  data.dig("followers", "total") || 0,
        artwork_l_url:    images[0].try(:[], "url"),
        artwork_l_width:  images[0].try(:[], "width"),
        artwork_l_height: images[0].try(:[], "height"),
        artwork_m_url:    images[1].try(:[], "url"),
        artwork_m_width:  images[1].try(:[], "width"),
        artwork_m_height: images[1].try(:[], "height"),
        artwork_s_url:    images[2].try(:[], "url"),
        artwork_s_width:  images[2].try(:[], "width"),
        artwork_s_height: images[2].try(:[], "height"),
        popularity:       data["popularity"] || 0,
      }
    end

    def create_by_name(name)
      artists = Spotify::Client.new.index_artists(name).dig("artists", "items") || []
      spotify_ids = artists.map {|artist| artist["id"] }
      spotify_ids.map {|id| create_by_spotify_id(id).first }
    end
  end
end
