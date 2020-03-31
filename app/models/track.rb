class Track < ApplicationRecord
  table_id :trak

  has_many :artist_has_tracks
  has_many :artists, through: :artist_has_tracks
  has_many :album_has_tracks
  has_many :albums, through: :album_has_tracks
  has_one  :apple_music_track
  has_one  :spotify_track

  enum status: { pending: 0, active: 1, ignore: 2 }

  scope :services, -> { eager_load(:apple_music_track, :spotify_track).map(&:service) }
  scope :names, -> { services.map(&:name) }

  def service
    (apple_music_track || spotify_track)
  end
end
