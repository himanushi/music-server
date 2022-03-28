# frozen_string_literal: true

class AlbumHasTrack < ::ApplicationRecord
  def table_id = 'bht'

  belongs_to :album
  belongs_to :track
end
