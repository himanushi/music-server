class Album < ApplicationRecord
  table_id :albm

  has_many :artist_has_albums
  has_many :artists, through: :artist_has_albums
  has_many :album_has_tracks
  has_many :tracks, through: :album_has_tracks
  has_one  :apple_music_album
  has_one  :spotify_album

  scope :include_services, -> { eager_load(:apple_music_album, :spotify_album) }
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
    (apple_music_album || spotify_album)
  end
end
