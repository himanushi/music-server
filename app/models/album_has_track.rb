class AlbumHasTrack < ApplicationRecord
  table_id :bht

  belongs_to :album
  belongs_to :track
end
