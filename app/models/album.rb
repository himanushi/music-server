class Album < ApplicationRecord
  table_id :albm

  has_many :artist_has_albums
  has_many :artists, through: :artist_has_albums
  has_many :album_has_tracks
  has_many :tracks, through: :album_has_tracks
  # iTunes と分けるため名前を変更している
  has_one  :apple_music_and_itunes_album, class_name: AppleMusicAlbum.name
  has_one  :spotify_album

  scope :include_services, -> { eager_load(:apple_music_and_itunes_album, :spotify_album) }
  scope :services, -> { include_services.map(&:service) }
  scope :names, -> { services.map(&:name) }

  class << self
    def find_by_isrc_or_create(album_attrs, tracks_attrs)
      isrc  = tracks_attrs.map {|attrs| attrs[:isrc] }
      album = joins(:tracks).where(tracks: { isrc: isrc } ).
              group(:id).having("count(*) = #{isrc.size}").first

      if album.present?
        # 過去の日時を正とする
        if album.release_date > album_attrs[:release_date]
          album.release_date = album_attrs[:release_date]
          album.save!
        end

        return album
      end

      tracks = tracks_attrs.map {|attrs| Track.find_or_initialize_by(attrs) }

      raise StandardError, "トラック数が違うっぽい" unless tracks.size == album_attrs[:total_tracks]

      album = new(album_attrs.merge(tracks: tracks))
      album.save!
      album
    end
  end

  def service
    (apple_music_and_itunes_album || spotify_album)
  end

  def apple_music_album
    @apple_music_album ||= pick_apple_album(true)
  end

  def itunes_album
    @itunes_album ||= pick_apple_album(false)
  end

  def pick_apple_album(is_apple_music)
    return nil unless apple_music_and_itunes_album.present?
    apple_music_and_itunes_album.playable == is_apple_music ? apple_music_and_itunes_album : nil
  end
end
