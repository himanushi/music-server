class SpotifyAlbum < ApplicationRecord
  table_id :spb

  include MusicServiceCreatable
  include SpotifyArtworkResizable
  include Albums::Compact

  belongs_to :album
  has_many :spotify_tracks, dependent: :destroy

  enum status: { pending: 0, active: 1, ignore: 2 }

  before_update :sync_status_spotify_tracks

  JAPANESE_REGEXP = /(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+/

  class << self
    def music_service_id_name
      "spotify_id"
    end

    def mapping(data)

      # @type var tracks_data: Array[{ "id" => String, "name" => String, "disc_number" => Integer, "track_number" => Integer, "explicit" => bool, "is_playable" => (bool | nil), "duration_ms" => Integer, "preview_url" => String, "popularity" => Integer, "external_ids" => { "isrc" => ::String }, "artists" => Array[{ "id" => String }] }]
      tracks_data  = data["tracks"]["items"]

      # @type var album_attrs: { release_date: Time, total_tracks: Integer }
      album_attrs  = to_album_attrs(data)

      # @type var tracks_attrs: Array[{ isrc: String }]
      tracks_attrs = tracks_data.map {|td| SpotifyTrack.to_track_attrs(td) }

      # @type var album: Album
      album = Album.find_by_isrc_or_create(album_attrs, tracks_attrs)

      data["artists"].each do |ad|

        # @type var artist: Artist?
        artist = (SpotifyArtist.find_by(spotify_id: ad["id"]) ||
                  SpotifyArtist.create_by_music_service_id(ad["id"]))&.artist
        artist&.albums&.push(album) if artist&.albums&.where(id: album.id)&.empty?
      end

      # @type var spotify_tracks: Array[SpotifyTrack]
      spotify_tracks = tracks_data.map do |td|
        SpotifyTrack.find_or_initialize_by(SpotifyTrack.mapping(td).merge({ status: album.status }))
      end

      # spotify はトラック番号に一意性がないため修正する
      # @type var correct_spotify_tracks: Array[SpotifyTrack]
      correct_spotify_tracks = []
      spotify_tracks.group_by(&:disc_number).map do |disc_number, tracks|
        tracks.each.with_index(1) {|track, index| track.track_number = index }
        correct_spotify_tracks = [*correct_spotify_tracks, *tracks]
      end

      # 同じアルバムで別のSpotify ID である場合がある(日本語版と英語版など)
      # そのため日本語表記のアルバムを優先する
      # 同じ Spotify ID の場合は何もしない
      if(album.spotify_album.present? && data["id"] != album.spotify_album.spotify_id)
        if(data["name"].match?(JAPANESE_REGEXP))
          # 日本語表記のアルバムを優先する
          IgnoreContent.create!(
            music_service_id: album.spotify_album.spotify_id,
            title: "Duplicate Spotify ID",
            reason: "Spotify では同じアルバムが登録されていることがあるため除外する(日本語)"
          )
          album.spotify_album.destroy!
        else
          # 英語表記のアルバムの場合は除外するのみ
          # TODO: 英語の場合はロールバックされるので考えること
          # IgnoreContent.create!(
          #   music_service_id: data["id"],
          #   title: "Duplicate Spotify ID",
          #   reason: "Spotify では同じアルバムが登録されていることがあるため除外する(英語)"
          # )
        end
      end

      # @type var images: Array[{ "url" => String, "width" => Integer, "height" => Integer }]
      images = data["images"][-3..-1] || []

      {
        album:            album,
        spotify_tracks:   correct_spotify_tracks,
        spotify_id:       data["id"],
        name:             data["name"],
        record_label:     data["label"],
        copyright:        data.dig("copyrights", 0, "text")[0...255] || "",
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

    def create_by_music_service_id(spotify_id)
      return unless IgnoreContent.where(music_service_id: spotify_id).empty?

      # @type var album_data: { "id" => String, "total_tracks" => Integer, "tracks" => { "items" => Array[{ "id" => String, "name" => String, "disc_number" => Integer, "track_number" => Integer, "explicit" => bool, "is_playable" => (bool | nil), "duration_ms" => Integer, "preview_url" => String, "popularity" => Integer, "external_ids" => { "isrc" => ::String }, "artists" => Array[{ "id" => String }] }] } }
      album_data = Spotify::Client.new.get_album(spotify_id)

      return unless album_data["id"].present?

      # @type var tracks_data: Array[{ "id" => String }]
      tracks_data = Spotify::Client.new.get_album_tracks(spotify_id)["items"]

      return unless tracks_data.present?

      # @type var track_ids: Array[String]
      track_ids = tracks_data.map {|t| t["id"] }

      # @type var tracks: Array[{ "id" => String, "name" => String, "disc_number" => Integer, "track_number" => Integer, "explicit" => bool, "is_playable" => (bool | nil), "duration_ms" => Integer, "preview_url" => String, "popularity" => Integer, "external_ids" => { "isrc" => ::String }, "artists" => Array[{ "id" => String }] }]
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
        SpotifyAlbum.create_or_update_by_data(album_data["id"], album_data)
      end
    end

    # トラックのISRC1件でアルバム特定し生成する
    def create_by_track_isrc(isrc)

      # @type var spotify_ids: Array[String]
      spotify_ids =
        Spotify::Client.new.get_track_by_isrc(isrc.upcase).
        dig("tracks", "items").try(:map) {|t| t.dig("album", "id") }.try(:compact) || []

      # Spotify は isrc が大文字小文字が決まっておらず大文字で検索してもヒットしないことあるため両方で検索する
      spotify_ids +=
        Spotify::Client.new.get_track_by_isrc(isrc.downcase).
        dig("tracks", "items").try(:map) {|t| t.dig("album", "id") }.try(:compact) || []

      return [] unless spotify_ids.present?

      spotify_ids.map do |spotify_id|
        create_by_music_service_id(spotify_id)
      end
    end
  end

  def music_service_id
    spotify_id
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
