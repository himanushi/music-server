class SpotifyAlbum < ApplicationRecord
  table_id :spb

  include SpotifyCreatable
  include SpotifyArtworkResizable
  include Albums::Compact

  belongs_to :album
  has_many :spotify_tracks, dependent: :destroy

  enum status: { pending: 0, active: 1, ignore: 2 }

  before_update :sync_status_spotify_tracks

  JAPANESE_REGEXP = /(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+/

  class << self
    def mapping(data)
      tracks_data  = data["tracks"]["items"]
      album_attrs  = to_album_attrs(data)
      tracks_attrs = tracks_data.map {|td| SpotifyTrack.to_track_attrs(td) }

      album = Album.find_by_isrc_or_create(album_attrs, tracks_attrs)

      data["artists"].each do |ad|
        artist = (SpotifyArtist.find_by(spotify_id: ad["id"]) ||
                  SpotifyArtist.create_by_spotify_id(ad["id"])).artist
        artist.albums.push(album) if artist.albums.where(id: album.id).empty?
      end

      spotify_tracks = tracks_data.map do |td|
        SpotifyTrack.find_or_initialize_by(SpotifyTrack.mapping(td).merge({ status: album.status }))
      end

      images = data["images"][-3..-1] || []

      # 同じアルバムで別のSpotify ID である場合がある(日本語版と英語版など)
      # そのため日本語表記のアルバムを優先する
      # 同じアルバム名の場合は何もしない
      if(album.spotify_album.present? &&
         data["name"].match?(JAPANESE_REGEXP) &&
         data["name"] != album.spotify_album.name)
        album.spotify_album.destroy!
      end

      {
        album:            album,
        spotify_tracks:   spotify_tracks,
        spotify_id:       data["id"],
        name:             data["name"],
        record_label:     data["label"],
        copyright:        data.dig("copyrights", 0, "text") || "",
        upc:              data.dig("external_ids", "upc") || "",
        popularity:       data["popularity"] || 0,
        artwork_l_url:    images.dig(0, "url"),
        artwork_l_width:  images.dig(0, "width"),
        artwork_l_height: images.dig(0, "height"),
        artwork_m_url:    images.dig(1, "url"),
        artwork_m_width:  images.dig(1, "width"),
        artwork_m_height: images.dig(1, "height"),
        artwork_s_url:    images.dig(2, "url"),
        artwork_s_width:  images.dig(2, "width"),
        artwork_s_height: images.dig(2, "height"),
        status:           album.status,
      }.merge(album_attrs)
    end

    def to_album_attrs(data)
      {
        release_date: DateUtil.data_to_datetime(data["release_date"]),
        total_tracks: data["total_tracks"],
      }
    end

    def create_by_spotify_id(spotify_id)
      album_data = Spotify::Client.new.get_album(spotify_id)

      return unless album_data["id"].present?

      tracks_data = Spotify::Client.new.get_album_tracks(spotify_id)["items"]

      return unless tracks_data.present?

      track_ids = tracks_data.map {|t| t["id"] }

      tracks = []
      # Spotify API 制限のため50件づつ実行
      # ref: https://developer.spotify.com/documentation/web-api/reference/tracks/get-several-tracks/
      track_ids.each_slice(50) do |ids|
        tracks.concat(Spotify::Client.new.get_tracks(ids)["tracks"])
      end
      tracks.compact!

      raise StandardError, "トラック数が違うっぽい" unless tracks.size == album_data["total_tracks"]

      # アルバム情報にトラック情報を結合
      album_data["tracks"]["items"] = tracks
      ActiveRecord::Base.transaction do
        SpotifyAlbum.create_or_update_by_data(album_data)
      end
    end

    # トラックのISRC1件でアルバム特定し生成する
    def create_by_track_isrc(isrc)
      spotify_ids =
        Spotify::Client.new.get_track_by_isrc(isrc).
        dig("tracks", "items").try(:map) {|t| t.dig("album", "id") }.try(:compact)

      return [] unless spotify_ids.present?

      spotify_ids.map do |spotify_id|
        create_by_spotify_id(spotify_id)
      end
    end
  end

  # albums tracks 全てで playable が存在するため共通化
  def playable
    true
  end

  def artwork_l
    @artwork_l ||= Artwork.new(url: artwork_l_url, width: artwork_l_width, height: artwork_l_height)
  end

  def artwork_m
    @artwork_m ||=  Artwork.new(url: artwork_m_url, width: artwork_m_width, height: artwork_m_height)
  end

  def sync_status_spotify_tracks
    ActiveRecord::Base.transaction do
      spotify_tracks.map do |t|
        t.__send__("#{self.status}!")
      end
    end
  end
end
