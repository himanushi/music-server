class Artist < ApplicationRecord
  table_id :arst

  include Artists::Status

  has_many :artist_has_albums
  has_many :albums, through: :artist_has_albums
  has_many :artist_has_tracks
  has_many :tracks, through: :artist_has_tracks
  has_many :apple_music_artists
  has_many :spotify_artists

  scope :include_albums, -> { eager_load(:albums) }
  scope :include_services, -> { eager_load(:apple_music_artists, :spotify_artists) }
  scope :services, -> { include_services.map(&:service) }
  scope :names, -> { services.map(&:name) }

  enum status: { pending: 0, active: 1, ignore: 2 }

  class << self
    def create_by_name(name)
      name = to_name(name)
      AppleMusicArtist.create_by_name(name)
      SpotifyArtist.create_by_name(name)
      where(name: name)
    end

    def to_name(name)
      name = name.to_s.
             # 英数を全角から半角へ変換
             tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z').
             # カタカナを半角から全角へ変換
             sub(/[\uFF61-\uFF9F]+/) { |str| str.unicode_normalize(:nfkc) }.
             # 半角全角スペースを削除して英語名の場合は名前ごとに区切ってキャメルケースにして半角スペースを追加する
             split(/\p{blank}/).map(&:camelcase).join(" ").gsub(/([^A-Za-z\s])\s([^A-Za-z\s])/, '\1\2')
      raise StandardError, "空文字のアーティスト名になっている" unless name.present?
      name
    end
  end

  def create_albums
    apple_music_artists.each {|am_art| am_art.create_albums }
    spotify_artists.each {|sp_art| sp_art.create_albums }
    self
  end

  def service
    (spotify_artists + apple_music_artists).first
  end
end
