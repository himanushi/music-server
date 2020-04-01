class AppleMusicTrack < ApplicationRecord
  table_id :amtr

  belongs_to :track
  belongs_to :apple_music_album

  enum status: { pending: 0, active: 1, ignore: 2 }

  class << self
    def mapping(data)
      attrs = data["attributes"]
      track_attrs = to_track_attrs(data)
      track = Track.find_or_create_by(track_attrs)

      # TODO: アーティスト紐付け, Apple music は正式な名前を返さないのでどうにかする
      artist = Artist.find_by(name: Artist.to_name(attrs["artistName"]))
      if artist.present? && artist.tracks.where(id: track.id).empty?
        artist.tracks.push(track)
      end

      {
        track:          track,
        apple_music_id: data["id"],
        name:           attrs["name"],
        disc_number:    attrs["discNumber"],
        track_number:   attrs["trackNumber"],
        has_lyrics:     attrs["hasLyrics"],
        playable:       attrs["playParams"].present?,
        duration_ms:    attrs["durationInMillis"],
        preview_url:    attrs.dig("previews", 0, "url"),
      }.merge(track_attrs)
    end

    def to_track_attrs(data)
      attrs = data["attributes"]

      {
        isrc: attrs["isrc"],
      }
    end
  end
end
