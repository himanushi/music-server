class AppleMusicAlbum < ApplicationRecord
  table_id :amal

  include AppleMusicCreatable

  belongs_to :album
  has_many :apple_music_tracks

  enum status: { pending: 0, active: 1, ignore: 2 }

  class << self
    def mapping(data)
      attrs        = data["attributes"]
      tracks_data  = data.dig("relationships", "tracks", "data")
      album_attrs  = to_album_attrs(data)
      tracks_attrs = tracks_data.map {|td| AppleMusicTrack.to_track_attrs(td) }

      album = Album.find_by_isrc_or_create(album_attrs, tracks_attrs)

      data.dig("relationships", "artists", "data").each do |ad|
        artist = (AppleMusicArtist.find_by(apple_music_id: ad["id"]) ||
                  AppleMusicArtist.create_by_apple_music_id(ad["id"])).artist
        artist.albums.push(album) if artist.albums.where(id: album.id).empty?
      end

      apple_music_tracks = tracks_data.map do |td|
        AppleMusicTrack.find_or_initialize_by(AppleMusicTrack.mapping(td))
      end

      {
        album:              album,
        apple_music_tracks: apple_music_tracks,
        apple_music_id:     data["id"],
        name:               attrs["name"],
        record_label:       attrs["recordLabel"],
        copyright:          attrs["copyright"],
        playable:           attrs["playParams"].present?,
        artwork_url:        attrs.dig("artwork", "url"),
        artwork_width:      attrs.dig("artwork", "width"),
        artwork_height:     attrs.dig("artwork", "height"),
      }.merge(album_attrs)
    end

    def to_album_attrs(data)
      attrs = data["attributes"]

      {
        release_date: DateUtil.data_to_datetime(attrs["releaseDate"]),
        total_tracks: attrs["trackCount"],
      }
    end

    def create_by_apple_music_id(apple_music_id)
      data = AppleMusic::Client.new.get_album(apple_music_id).dig("data", 0)

      return unless data.present?

      unless data["attributes"]["trackCount"] == data["relationships"]["tracks"]["data"].size
        raise StandardError, "トラック数が合わないよ"
      end

      create_by_data(data)
    end
  end
end
