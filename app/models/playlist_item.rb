class PlaylistItem < ApplicationRecord
  table_id :psi

  belongs_to :playlist
  belongs_to :track

  scope :include_tracks, -> { eager_load(track: [:apple_music_and_itunes_tracks]) }
end
