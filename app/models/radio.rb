class Radio < ApplicationRecord
  table_id :rdo

  belongs_to :playlist
  has_many :radio_items, dependent: :destroy
  has_many :favorites, as: :favorable, dependent: :destroy

  scope :include_playlists,  -> { eager_load(:playlist) }

  def play
    self.start_datetime = DateTime.now
    save!
  end

  def tracks
    radio_items.order(:track_number).include_tracks.map(&:track)
  end

  def apple_music_tracks
    tracks.map do |track|
      track.apple_music_and_itunes_tracks.first
    end.flatten
  end

  def durations
    @_durations ||= apple_music_tracks.map do |track|
      if track.playable
        track.duration_ms
      elsif track.duration_ms > 30000
        30000
      else
        track.duration_ms
      end
    end
  end

  def past_ms
    return unless self.start_datetime
    time = DateTime.now.to_time - self.start_datetime.to_time
    (time * 1000).floor
  end

  def current_track_number_and_time
    ms = past_ms
    track_number = nil
    time = nil

    times = durations
    all_time = times.sum
    rest_time = ms % all_time

    times.each.with_index(1) do |duration, index|
      if rest_time > duration
        rest_time -= duration
      else
        track_number = index
        time = rest_time
        break
      end
    end

    [track_number, time]
  end

  def copy_items!
    ActiveRecord::Base.transaction do
      radio_items.delete_all

      order = random ? "RAND()" : { track_number: :asc }

      playlist.playlist_items.order(order).map.with_index(1) do |item, index|
        radio_items.build(track_id: item.track_id, track_number: index)
      end

      save!
    end
  end
end
