class AppleMusicTrack < ApplicationRecord
  table_id :amt

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
      # TOTO: Steep エラーいつか直す。 nil に対して tracks を実行しているから。
      #       TypeScript と違い unless nil でやっても内部で実行しているとエラーになる。
      #       仕方がないのでぼっち演算子で誤魔化す
      if !artist.nil? && artist&.tracks&.where(id: track.id)&.empty?
        artist&.tracks&.push(track)
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

  def artwork_m
    @artwork_m ||= apple_music_album.artwork_m
  end
end
