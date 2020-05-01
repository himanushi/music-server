class ArtistHasTrack < ApplicationRecord
  table_id :aht

  belongs_to :artist
  belongs_to :track
end
