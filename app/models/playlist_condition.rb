# frozen_string_literal: true

class PlaylistCondition < ::ApplicationRecord
  def table_id = 'ptc'

  belongs_to :playlist

  enum order: { popularity: 0, release_date: 1 }
  enum direction: { asc: 0, desc: 1 }
end
