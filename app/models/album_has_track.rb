class AlbumHasTrack < ApplicationRecord
  table_id :altr

  belongs_to :album
  belongs_to :track
end
