# frozen_string_literal: true

class Album < ::ApplicationRecord
  def table_id() = 'abm'

  has_many :artist_has_albums, dependent: :destroy
  has_many :artists, through: :artist_has_albums
  has_many :album_has_tracks, dependent: :destroy
  has_many :tracks, through: :album_has_tracks
  has_one :apple_music_album, dependent: :destroy
  has_many :favorites, as: :favorable, dependent: :destroy

  enum status: { pending: 0, active: 1, ignore: 2 }

  delegate :apple_music_id,
           :apple_music_playable,
           :name,
           :upc,
           :record_label,
           :copyright,
           :artwork_m,
           :artwork_l,
           to: :service

  before_update :sync_tracks_status, if: :status_changed?

  def sync_tracks_status
    tracks.each { |track| track.update!(status: status) }
  end

  def service() = apple_music_album

  # アルバム作曲者とトラック作曲者全員
  def composers
    (artists.active.to_a + tracks_composers).uniq
  end

  # アルバムのトラックの作曲者
  def tracks_composers
    ::Artist.distinct.where(id: tracks.includes(:artists).pluck('artists.id')).to_a
  end

  def force_ignore
    ::ActiveRecord::Base.transaction do
      if (am_album = apple_music_album)
        ::IgnoreContent.create!(music_service_id: am_album.apple_music_id, reason: '除外対象のアルバムのため')
        reload
        destroy
      end
    end
  end

  def update_services
    return self unless (am_album = apple_music_album)

    begin
      ::AppleMusic::Album.create_full(am_album.apple_music_id, force: true)
    rescue ::StandardError => e
      raise(e) unless e.message == '404: Not Found'
    end

    self
  end

  def to_url
    "#{::ENV['PRODUCTION_APP_URL']}/albums/#{id}"
  end

  class << self
    def find_by_isrc(isrc)
      joins(:tracks).where(tracks: { isrc: isrc }, total_tracks: isrc.size)
                    .group('albums.id').having('count(*) = albums.total_tracks').first
    end

    def cache?(conditions:)
      cache = true
      cache = false if conditions.key?(:favorite)
      cache
    end

    def generate_relation(conditions:, context:)
      # @type var album_ids: ::Array[::String]
      # @type var artist_ids: ::Array[::String]
      # @type var track_ids: ::Array[::String]
      # @type var name: ::String

      conditions = { status: [:active] }.merge(conditions)
      relation = ::Album.includes(:apple_music_album)

      if conditions.key?(:name)
        name = conditions.delete(:name)
        relation = relation.joins(:apple_music_album).where('apple_music_albums.name like :name', name: "%#{name}%")
      end

      if conditions.key?(:artist_ids)
        artist_ids = conditions.delete(:artist_ids)
        album_ids = ::Album.includes(:artists).where(artists: { id: artist_ids }).ids
        track_ids = ::Track.includes(:artists).where(artists: { id: artist_ids }).ids
        album_ids += ::Album.includes(:tracks).where(tracks: { id: track_ids }).ids
        relation = relation.where(id: album_ids)
      end

      if conditions.key?(:track_ids)
        track_ids = conditions.delete(:track_ids)
        relation = relation.includes(:tracks).where(tracks: { id: track_ids })
      end

      if conditions.delete(:favorite)
        relation = relation.joins(:favorites).where(favorites: { user_id: context[:current_info][:user].id })
      end

      relation.where(conditions)
    end

    def all_pending_to_ignore
      ::ActiveRecord::Base.transaction do
        where(status: :pending).each { |album| album.ignore! }
      end
    end

    # cron で実行する
    def create_by_new_releases
      # @type var albums_ids: ::Array[::String]
      albums_ids = []

      result_chart_albums = ::AppleMusic::Api.new.get_chart_albums(16, 100)
      albums_data = result_chart_albums['results']['albums'].first
      if albums_data
        albums_data['data'].each do |album_data|
          albums_ids << album_data['id']
        end
      end

      result_chart_tracks = ::AppleMusic::Api.new.get_chart_tracks(16, 100)
      tracks_data = result_chart_tracks['results']['songs'].first
      if tracks_data
        tracks_data['data'].each do |track_data|
          album_id = track_data['attributes']['url'][%r{/([0-9]+)\?}, 1]
          albums_ids << album_id if album_id
        end
      end

      return [] if albums_ids.empty?

      albums_ids.uniq.each do |albums_id|
        ::ActiveRecord::Base.transaction do
          ::AppleMusic::Album.create_full(albums_id)
        end
      rescue ::StandardError => e
        # エラーは一旦スキップする
        ::Rails.logger.info("Apple Music ID: #{albums_id}, Error: #{e.message}")
      end

      nil
    end
  end
end
