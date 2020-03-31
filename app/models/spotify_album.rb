class SpotifyAlbum < ApplicationRecord
  table_id :spal

  include SpotifyCreatable

  belongs_to :album
  has_many :spotify_tracks

  enum status: { pending: 0, active: 1, ignore: 2 }

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
        SpotifyTrack.find_or_initialize_by(SpotifyTrack.mapping(td))
      end

      images = data["images"][-3..-1] || []

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
      SpotifyAlbum.create_by_data album_data
    end
  end
end
