class PlaylistItem < ApplicationRecord
  table_id :psi

  belongs_to :playlist
  belongs_to :track
end
