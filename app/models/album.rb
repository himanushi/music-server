class Album < ApplicationRecord
  table_id :abm

  include Albums::Mix
  include Albums::Status

  has_many :artist_has_albums, dependent: :destroy
  has_many :artists, through: :artist_has_albums
  has_many :album_has_tracks, dependent: :destroy
  has_many :tracks, through: :album_has_tracks
  # iTunes と分けるため名前を変更している
  has_one  :apple_music_and_itunes_album, class_name: AppleMusicAlbum.name, dependent: :destroy
  has_one  :spotify_album, dependent: :destroy

  scope :include_artists, -> { eager_load(:artists) }
  scope :include_tracks, -> { eager_load(:tracks) }
  scope :include_services, -> { eager_load(:apple_music_and_itunes_album, :spotify_album) }
  scope :services, -> { include_services.map(&:service) }
  scope :names, -> { services.map(&:name) }

  enum status: { pending: 0, active: 1, ignore: 2 }

  # 音楽サービスが一つでも存在した場合はエラー
  before_destroy :validate_exists_services

  class << self
    def find_by_isrc_or_create(album_attrs, tracks_attrs)
      isrc  = tracks_attrs.map {|attrs| attrs[:isrc] }
      album = joins(:tracks).where(tracks: { isrc: isrc }, total_tracks: isrc.size).
              group("albums.id").having("count(*) = albums.total_tracks").first

      if album.present?
        # 最新の日時を正とする
        if album.release_date <= album_attrs[:release_date]
          album.release_date = album_attrs[:release_date]
          album.save!
        end

        return album
      end

      tracks = tracks_attrs.map {|attrs| Track.find_or_initialize_by(attrs) }

      unless tracks.size == album_attrs[:total_tracks]
        raise StandardError, "アルバムのトラック数が実トラック数と相違がある"
      end

      album = new(album_attrs.merge(tracks: tracks))
      album.save!
      album
    end
  end

  def service
    @service ||= (apple_music_and_itunes_album || spotify_album)
  end

  def services
    [apple_music_and_itunes_album, spotify_album].compact
  end

  def apple_music_album
    @apple_music_album ||= pick_apple_album(true)
  end

  def itunes_album
    @itunes_album ||= pick_apple_album(false)
  end

  private def pick_apple_album(is_apple_music)
      return nil unless apple_music_and_itunes_album.present?
      apple_music_and_itunes_album.playable == is_apple_music ? apple_music_and_itunes_album : nil
  end

  # すでに存在するアルバムから全ての音楽サービスのアルバムを必死に探し作成する
  def create_all_service_albums
    # アルバムの一曲目のISRCを基準に全てのサービスで検索する
    # まとめアルバムのような場合は複数のアルバムにまたいで存在する曲がある
    _isrc =
      if apple_music_and_itunes_album.present?
        apple_music_and_itunes_album.apple_music_tracks.order(:disc_number, :track_number).first.isrc
      elsif spotify_album.present?
        spotify_album.spotify_tracks.order(:disc_number, :track_number).first.isrc
      else
        return []
      end

    albums = []
    albums += AppleMusicAlbum.create_by_track_isrc(_isrc).map(&:album)
    albums += SpotifyAlbum.create_by_track_isrc(_isrc).map(&:album)
    albums.compact
  end

  def validate_exists_services
    if services.present?
      raise StandardError, "音楽サービスが一つでも存在する場合は削除できませんよ！確認してください"
    end
  end
end
