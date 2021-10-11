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

  has_many :favorites, as: :favorable, dependent: :destroy

  scope :include_artists, -> { eager_load(:artists) }
  scope :include_tracks, -> { eager_load(:tracks) }
  scope :include_services, -> { eager_load(:apple_music_and_itunes_album) }
  scope :services, -> { include_services.map(&:service) }

  enum status: { pending: 0, active: 1, ignore: 2 }

  # 音楽サービスが一つでも存在した場合はエラー
  before_destroy :validate_exists_services

  class << self
    def find_by_isrc_or_create(album_attrs, tracks_attrs)

      # @type var isrc: Array[String]
      isrc  = tracks_attrs.map {|attrs| attrs[:isrc] }

      # @type var album: Album?
      album = joins(:tracks).where(tracks: { isrc: isrc }, total_tracks: isrc.size).
              group("albums.id").having("count(*) = albums.total_tracks").first

      unless tracks_attrs.size > 0
        raise StandardError, "アルバムのトラック数が0件なので何かしらのバグがある"
      end

      if album.present?
        # 最新の日時を正とする
        # @type var album: Album
        if album.release_date <= album_attrs[:release_date]
          album.release_date = album_attrs[:release_date]
          album.save!
        end

        return album
      end

      # @type var tracks: Array[Track]
      tracks = tracks_attrs.map {|attrs| Track.find_or_initialize_by(attrs) }

      unless tracks.size == album_attrs[:total_tracks]
        raise StandardError, "アルバムのトラック数が実トラック数と相違がある"
      end

      # @type var attributes: Hash[(Symbol | :release_date | :total_tracks), (Array[Track] | Integer | Time)]
      attributes = album_attrs.merge(tracks: tracks)

      # @type var album: Album
      album = new(attributes)
      album.save!
      album
    end

    def all_pending_to_ignore
      where(status: :pending).map do |album|
        album.ignore!
        album
      end
    end

    def create_by_new_releases
      AppleMusicAlbum.create_by_new_releases
    end
  end

  def service
    @service ||= apple_music_and_itunes_album
  end

  def services
    [apple_music_and_itunes_album].compact
  end

  # アルバム作曲者とトラック作曲者全員
  def composers
    (artists.active.to_a + tracks_composers).uniq
  end

  # アルバムのトラックの作曲者
  def tracks_composers
    Artist.distinct.where(id: tracks.include_artists.pluck("artists.id")).to_a
  end

  def apple_music_album
    @apple_music_album ||= pick_apple_album(true)
  end

  def itunes_album
    @itunes_album ||= pick_apple_album(false)
  end

  private def pick_apple_album(is_apple_music)
    return nil if apple_music_and_itunes_album.nil?
    apple_music_and_itunes_album.playable == is_apple_music ? apple_music_and_itunes_album : nil
  end

  # すでに存在するアルバムから全ての音楽サービスのアルバムを必死に探し作成する
  def create_all_service_albums
    # アルバムの一曲目のISRCを基準に全てのサービスで検索する
    # まとめアルバムのような場合は複数のアルバムにまたいで存在する曲がある
    # @type var _isrc: String
    _isrc =
      if !apple_music_and_itunes_album.nil?
        apple_music_and_itunes_album.apple_music_tracks.order(:disc_number, :track_number).first.isrc
      else
        return []
      end

    albums = []
    albums += AppleMusicAlbum.create_by_track_isrc(_isrc).map(&:album)
    albums.compact
  end

  def validate_exists_services
    unless services.empty?
      raise StandardError, "音楽サービスが一つでも存在する場合は削除できませんよ！確認してください"
    end
  end

  # レコードを削除し関連音楽サービスを除外コンテンツにする
  def force_ignore
    ActiveRecord::Base.transaction do
      services.each do |_service|
        IgnoreContent.create!(
          music_service_id: _service.music_service_id,
          title: "Force ignore Album",
          reason: "除外対象のアルバムのため"
        )

        _service.destroy
      end

      # 関連音楽サービスが削除されたことを同期する
      reload
      destroy
    end
  end

  def to_path
    "/#{id}"
  end

  def to_url
    "#{ENV['PRODUCTION_APP_URL']}/albums#{to_path}"
  end
end
