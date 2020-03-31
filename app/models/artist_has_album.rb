class ArtistHasAlbum < ApplicationRecord
  table_id :aral

  belongs_to :artist
  belongs_to :album
end
