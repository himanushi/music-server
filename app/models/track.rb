class Track < ApplicationRecord
  table_id :trk

  has_many :artist_has_tracks, dependent: :destroy
  has_many :artists, through: :artist_has_tracks
  has_many :album_has_tracks, dependent: :destroy
  has_many :albums, through: :album_has_tracks
  has_many :apple_music_and_itunes_tracks, class_name: AppleMusicTrack.name, dependent: :destroy
  has_many :spotify_tracks, dependent: :destroy

  enum status: { pending: 0, active: 1, ignore: 2 }

  scope :include_artists, -> { eager_load(:artists) }
  scope :include_albums, -> { eager_load(:albums) }
  scope :include_services, -> { eager_load(:apple_music_and_itunes_tracks, :spotify_tracks) }
  scope :include_album_services, -> { eager_load(apple_music_and_itunes_tracks: :apple_music_album, spotify_tracks: :spotify_album) }
  scope :services, -> { include_services.map(&:service) }
  scope :names, -> { services.map(&:name) }

  def service
    @service ||= (apple_music_and_itunes_tracks + spotify_tracks).first
  end

  def apple_music_tracks
    @apple_music_tracks ||= pick_apple_track(true)
  end

  def itunes_tracks
    @itunes_tracks ||= pick_apple_track(false)
  end

  def pick_apple_track(is_apple_music)
    return [] unless apple_music_and_itunes_tracks.present?
    apple_music_and_itunes_tracks.select {|track| track.playable == is_apple_music }
  end
end
