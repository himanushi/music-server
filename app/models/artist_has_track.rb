class ArtistHasTrack < ApplicationRecord
  table_id :artr

  belongs_to :artist
  belongs_to :track
end
