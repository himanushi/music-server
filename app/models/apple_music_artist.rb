# frozen_string_literal: true

class AppleMusicArtist < ::ApplicationRecord
  def table_id() = 'ama'

  belongs_to :artist
end
