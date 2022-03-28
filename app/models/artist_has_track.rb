# frozen_string_literal: true

class ArtistHasTrack < ::ApplicationRecord
  def table_id = 'aht'

  belongs_to :artist
  belongs_to :track
end
