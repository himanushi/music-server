# frozen_string_literal: true

class ArtistHasAlbum < ::ApplicationRecord
  def table_id() = 'ahb'

  belongs_to :artist
  belongs_to :album
end
