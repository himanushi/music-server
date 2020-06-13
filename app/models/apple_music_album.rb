class AppleMusicAlbum < ApplicationRecord
  table_id :amb

  include MusicServiceCreatable
  include Albums::Compact

  belongs_to :album
  has_many :apple_music_tracks, dependent: :destroy

  enum status: { pending: 0, active: 1, ignore: 2 }

  before_update :sync_status_apple_music_tracks

  class << self
    def music_service_id_name
      "apple_music_id"
    end

    def mapping(data)
      attrs        = data["attributes"]
      tracks_data  = data.dig("relationships", "tracks", "data")
      album_attrs  = to_album_attrs(data)
      tracks_attrs = tracks_data.map {|td| AppleMusicTrack.to_track_attrs(td) }

      album = Album.find_by_isrc_or_create(album_attrs, tracks_attrs)

      data.dig("relationships", "artists", "data").each do |ad|
        apple_music_artist =
          AppleMusicArtist.find_by(apple_music_id: ad["id"]) ||
          AppleMusicArtist.create_by_music_service_id(ad["id"])

        # locale: :jp で参照できないアーティストがいる
        next unless apple_music_artist.present?

        artist = apple_music_artist.artist
        artist.albums.push(album) if artist.albums.where(id: album.id).empty?
      end

      apple_music_tracks = tracks_data.map do |td|
        AppleMusicTrack.find_or_initialize_by(AppleMusicTrack.mapping(td).merge({ status: album.status }))
      end

      {
        album:              album,
        apple_music_tracks: apple_music_tracks,
        apple_music_id:     data["id"],
        name:               attrs["name"],
        record_label:       attrs["recordLabel"],
        copyright:          attrs["copyright"] || attrs["recordLabel"],
        playable:           attrs["playParams"].present?,
        artwork_url:        attrs.dig("artwork", "url"),
        artwork_width:      attrs.dig("artwork", "width"),
        artwork_height:     attrs.dig("artwork", "height"),
        status:             album.status,
      }.merge(album_attrs)
    end

    def to_album_attrs(data)
      attrs = data["attributes"]

      {
        release_date: DateUtil.data_to_datetime(attrs["releaseDate"]),
        total_tracks: attrs["trackCount"],
      }
    end

    def create_by_music_service_id(apple_music_id)
      return unless IgnoreContent.where(music_service_id: apple_music_id).empty?

      data = AppleMusic::Client.new.get_album(apple_music_id).dig("data", 0)

      return unless data.present?

      unless data["attributes"]["trackCount"] == data["relationships"]["tracks"]["data"].size
        # TODO: いつか起きるかもしれないバグをなんとかする。
        # アルバムトラック数と実トラック数が合わないことがある。これはおそらく権利の都合上配信ができないトラックがあるから。
        # もともとエラーにしていたが、仕方なくトラック数を調整することにした。
        # これは AppleMusic::Client.new.get_album が絶対にエラーが発生しなければ問題はない。
        # しかし、AppleMusic::Client.new.get_album で全ての Track を取得できなかった場合、不正なデータとなる可能性がある。
        # raise StandardError, "トラック数が合わないよ"
        data["attributes"]["trackCount"] = data["relationships"]["tracks"]["data"].size
      end

      ActiveRecord::Base.transaction do
        create_or_update_by_data(data["id"], data)
      end
    end

    # トラックのISRC1件でアルバム特定し生成する
    def create_by_track_isrc(isrc)
      apple_music_ids =
        AppleMusic::Client.new.get_track_by_isrc(isrc).
        dig("data", 0, "relationships", "albums", "data").try(:map){|d| d["id"] }.try(:compact)

      return [] unless apple_music_ids.present?

      apple_music_ids.map do |apple_music_id|
        create_by_music_service_id(apple_music_id)
      end
    end
  end

  def artwork_l
    @artwork_l ||= build_artwork(640)
  end

  def artwork_m
    @artwork_m ||= build_artwork(300)
  end

  private def build_artwork(max_size)
    height = artwork_height > max_size ? max_size : artwork_height
    width  = ((artwork_height.to_f / artwork_height.to_f) * height).to_i
    url    = artwork_url.gsub("{w}", width.to_s).gsub("{h}", height.to_s)
    Artwork.new(url: url, width: width, height: height)
  end

  def sync_status_apple_music_tracks
    ActiveRecord::Base.transaction do
      apple_music_tracks.map do |t|
        t.__send__("#{self.status}!")
      end
    end
  end
end
