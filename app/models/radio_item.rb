class RadioItem < ApplicationRecord
  table_id :rdi

  belongs_to :radio
  belongs_to :track

  scope :include_tracks, -> { eager_load(track: :apple_music_and_itunes_tracks) }
end
