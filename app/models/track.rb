class Track < ApplicationRecord
  table_id :trk

  has_many :artist_has_tracks
  has_many :artists, through: :artist_has_tracks
  has_many :album_has_tracks
  has_many :albums, through: :album_has_tracks
  has_many :apple_music_tracks
  has_many :spotify_tracks

  enum status: { pending: 0, active: 1, ignore: 2 }

  scope :include_artists, -> { eager_load(:artists) }
  scope :include_services, -> { eager_load(:apple_music_tracks, :spotify_tracks) }
  scope :services, -> { include_services.map(&:service) }
  scope :names, -> { services.map(&:name) }

  def service
    (apple_music_tracks || spotify_tracks).first
  end
end
