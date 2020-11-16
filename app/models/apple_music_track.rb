class AppleMusicTrack < ApplicationRecord
  table_id :amt

  belongs_to :track
  belongs_to :apple_music_album

  enum status: { pending: 0, active: 1, ignore: 2 }

  class << self
    def mapping(data)
      attrs = data["attributes"]

      # @type var track_attrs: { isrc: String }
      track_attrs = to_track_attrs(data)

      # @type var track: Track
      track = Track.find_or_create_by(track_attrs)

      # TODO: アーティスト紐付け, Apple music は正式な名前を返さないのでどうにかする
      # @type var artist: Artist?
      artist = Artist.find_by(name: Artist.to_name(attrs["artistName"]))
      if !artist.nil? && artist&.tracks&.where(id: track.id)&.empty?
        # @type var artist: Artist
        artist.tracks.push(track)
      end

      # ミュージックビデオなどの場合
      other_data =
        if data["type"] != "songs"
          {
            disc_number: 0,
            has_lyrics: false,
            duration_ms: 0,
          }
        else
          {}
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
        artwork_url:    attrs.dig("artwork", "url"),
        artwork_width:  attrs.dig("artwork", "width"),
        artwork_height: attrs.dig("artwork", "height"),
        status:         track.status,
      }.merge(track_attrs).merge(other_data)
    end

    def to_track_attrs(data)
      attrs = data["attributes"]

      {
        isrc: attrs["isrc"],
      }
    end
  end

  def music_service_id
    apple_music_id
  end

  def artwork_l
    @artwork_l ||= build_artwork(640)
  end

  def artwork_m
    @artwork_m ||= build_artwork(300)
  end

  private def build_artwork(max_size)

    # @type var height: Integer
    height = artwork_height > max_size ? max_size : artwork_height

    # @type var width: Integer
    width  = ((artwork_height.to_f / artwork_height.to_f) * height).to_i

    # @type var url: String
    url    = artwork_url.gsub("{w}", width.to_s).gsub("{h}", height.to_s)
    Artwork.new(url: url, width: width, height: height)
  end
end
