# frozen_string_literal: true

class PlaylistItem < ::ApplicationRecord
  def table_id = 'psi'

  belongs_to :playlist
  belongs_to :track
end
