class Artist < ApplicationRecord
  table_id :art

  include Artists::Status
  include Artists::Mix

  has_many :artist_has_albums, dependent: :destroy
  has_many :albums, through: :artist_has_albums
  has_many :artist_has_tracks, dependent: :destroy
  has_many :tracks, through: :artist_has_tracks
  has_many :apple_music_artists, dependent: :destroy

  has_many :favorites, as: :favorable, dependent: :destroy

  scope :include_album_services, -> { eager_load(albums: :apple_music_and_itunes_album) }
  scope :include_albums, -> { eager_load(:albums) }
  scope :include_tracks, -> { eager_load(:tracks) }
  scope :include_services, -> { eager_load(:apple_music_artists) }
  scope :services, -> { include_services.map(&:service) }
  scope :names, -> { services.map(&:name) }

  enum status: { pending: 0, active: 1, ignore: 2 }

  FORCE_IGNORE_NAMES = %w[V.A. ヴァリアス・アーティスト]

  class << self
    def create_by_name(name)
      name = to_name(name)
      find_or_create_by!(name: name)
      AppleMusicArtist.create_by_name(name)
      where(name: name)
    end

    def to_name(name)
      name = name.to_s.
             # 英数を全角から半角へ変換
             tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z').
             # カタカナを半角から全角へ変換
             sub(/[\uFF61-\uFF9F]+/) { |str| str.unicode_normalize(:nfkc) }.
             # 半角全角スペースを削除して英語名の場合は名前ごとに区切ってキャメルケースにして半角スペースを追加する
             split(/\p{blank}/).map {|n| n.camelize }.join(" ").gsub(/([^A-Za-z\s])\s([^A-Za-z\s])/, '\1\2')
      raise StandardError, "空文字のアーティスト名になっている" unless name.present?
      name
    end

    def all_pending_to_ignore
      where(status: :pending).map do |artist|
        artist.ignore!
        artist
      end
    end

    def all_create_albums
      active_artists = where(status: :active)
      rate = active_artists.size / 100.to_f
      active_artists.map.with_index do |artist, index|
        Rails.logger.info("---------------- #{artist.name} #{(index / rate).round}% ----------------")
        artist.create_albums
      end
      Rails.cache.clear
    end
  end

  def create_albums
    apple_music_artists.each {|am_art| am_art.create_albums }
    self
  end

  def service
    @service ||= (apple_music_artists.to_a).first
  end

  def to_path
    "/#{id}"
  end

  def to_url
    "#{ENV['PRODUCTION_APP_URL']}/artists#{to_path}"
  end
end
