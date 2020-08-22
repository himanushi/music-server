class AppleMusicArtist < ApplicationRecord
  table_id :ama

  include MusicServiceCreatable

  belongs_to :artist

  enum status: { pending: 0, active: 1, ignore: 2 }

  class << self
    def music_service_id_name
      "apple_music_id"
    end

    def mapping(data)

      # @type ver name: String
      name   = Artist.to_name(data.dig("attributes", "name"))

      # @type ver artist: Artist
      artist = Artist.find_or_create_by(name: name)

      {
        artist_id:      artist.id,
        apple_music_id: data["id"],
        name:           name,
        status:         artist.status,
      }
    end

    def create_by_name(name)

      # @type ver artists: Array[{ "id" => String }]
      artists = AppleMusic::Client.new.index_artists(name).dig("results", "artists", "data") || []

      # @type ver apple_music_ids: Array[String]
      apple_music_ids = artists.map {|artist| artist["id"] }
      apple_music_ids.map {|id| find_or_create_by_music_service_id(id) }
    end

    def create_by_music_service_id(apple_music_id)
      return unless IgnoreContent.where(music_service_id: apple_music_id).empty?

      data = AppleMusic::Client.new.get_artist(apple_music_id).dig("data", 0)
      return nil unless data.present?
      create_or_update_by_data(data["id"], data)
    end
  end

  def music_service_id
    apple_music_id
  end

  def create_albums

    # @type ver albums_ids: Array[String]
    albums_ids = []

    data = AppleMusic::Client.new.get_artist_albums(apple_music_id)["data"]
    if data.present?
      albums_ids += data.map {|album| album["id"] }
    end

    # V.A などの取得不可なアルバムに対応するため携わっているトラックからアルバムを取得する
    data = AppleMusic::Client.new.get_artist_tracks(apple_music_id, {}, repeat: 5)["data"]
    if data.present?
      # 以下のようなURLからアルバムIDを抽出
      # https://music.apple.com/jp/album/999999999?i=999999999
      # https://music.apple.com/jp/album/アルバム名/999999999?i=999999999
      albums_ids += data.map {|track| track["attributes"]["url"][/\/([0-9]+)\?/, 1] }
    end

    return [] if albums_ids.empty?

    albums_ids.uniq.map do |albums_id|
      AppleMusicAlbum.find_or_create_by_music_service_id(albums_id) rescue nil
    end.compact
  end

  def artwork_l
    @artwork_l ||= Artwork.new(url: nil, width: 640, height: 640)
  end

  def artwork_m
    @artwork_m ||=  Artwork.new(url: nil, width: 300, height: 300)
  end
end
