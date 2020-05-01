class AppleMusicArtist < ApplicationRecord
  table_id :ama

  include AppleMusicCreatable

  belongs_to :artist

  enum status: { pending: 0, active: 1, ignore: 2 }

  class << self
    def mapping(data)
      name   = Artist.to_name(data.dig("attributes", "name"))
      artist = Artist.find_or_create_by(name: name)

      {
        artist_id:      artist.id,
        apple_music_id: data["id"],
        name:           name,
      }
    end

    def create_by_name(name)
      artists = AppleMusic::Client.new.index_artists(name).dig("results", "artists", "data") || []
      apple_music_ids = artists.map {|artist| artist["id"] }
      apple_music_ids.map {|id| find_or_create_by_apple_music_id(id) }
    end

    def create_by_apple_music_id(apple_music_id)
      data = AppleMusic::Client.new.get_artist(apple_music_id).dig("data", 0)
      return nil unless data.present?
      create_or_update_by_data(data)
    end
  end

  def create_albums
    albums_ids = []

    data = AppleMusic::Client.new.get_artist_albums(apple_music_id)["data"]
    if data.present?
      albums_ids += data.map {|album| album["id"] }
    end

    data = AppleMusic::Client.new.get_artist_tracks(apple_music_id, {}, repeat: 5)["data"]
    if data.present?
      # 以下のようなURLからアルバムIDを抽出
      # https://music.apple.com/jp/album/999999999?i=999999999
      # https://music.apple.com/jp/album/アルバム名/999999999?i=999999999
      albums_ids += data.map {|track| track["attributes"]["url"][/\/([0-9]+)\?/, 1] }
    end

    return [] unless albums_ids.present?

    albums_ids.uniq.map do |albums_id|
      AppleMusicAlbum.find_or_create_by_apple_music_id(albums_id) rescue nil
    end.compact
  end

  def artwork_l
    @artwork_l ||= Artwork.new(url: nil, width: 640, height: 640)
  end

  def artwork_m
    @artwork_m ||=  Artwork.new(url: nil, width: 300, height: 300)
  end

  def build_artwork(max_size)
    height = artwork_height > max_size ? max_size : artwork_height
    width  = ((artwork_height.to_f / artwork_height.to_f) * height).to_i
    url    = artwork_url.gsub("{w}", width.to_s).gsub("{h}", height.to_s)
    Artwork.new(url: url, width: width, height: height)
  end
end
