class ArtistHasAlbum < ApplicationRecord
  table_id :ahb

  belongs_to :artist
  belongs_to :album
end
