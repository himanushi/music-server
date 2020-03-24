class Artist < ApplicationRecord
  table_id :arst

  has_many :apple_music_artists
  has_many :spotify_artists

  enum status: { pending: 0, active: 1, ignore: 2 }
end
