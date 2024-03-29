# frozen_string_literal: true

class AppleMusicAlbum < ::ApplicationRecord
  def table_id = 'amb'

  belongs_to :album
  has_many :apple_music_tracks, dependent: :destroy

  class << self
    def create_by_data(data)
      raise(::StandardError, 'album data が存在しない') unless (album_data = data['data'].first)

      isrc = album_data['relationships']['tracks']['data'].map { |track_data| track_data['attributes']['isrc'] }
      album = ::Album.find_by_isrc(isrc) || ::Album.find_or_initialize_by(upc: album_data['attributes']['upc'].upcase)
      apple_music_album = album.apple_music_album
      apple_music_album.destroy! if apple_music_album

      instance = new(mapping(album_data).merge(mapping_relation(album_data)))
      instance.save!
      instance
    end

    def mapping(data)
      attrs = data['attributes']
      artwork = attrs['artwork']

      release_date = ::Convert.to_time(attrs['releaseDate'])

      total_tracks = data['relationships']['tracks']['data'].size || attrs['trackCount']

      {
        apple_music_id: data['id'],
        name: attrs['name'],
        playable: attrs['playParams'].present?,
        upc: attrs['upc'].upcase,
        release_date: release_date,
        total_tracks: total_tracks,
        record_label: attrs['recordLabel'] || '',
        copyright: attrs['copyright'] || '',
        artwork_url: artwork['url'],
        artwork_width: artwork['width'],
        artwork_height: artwork['height']
      }
    end

    def mapping_relation(data)
      tracks_data = data['relationships']['tracks']['data']

      # @type var apple_music_tracks: ::Array[::AppleMusicTrack]
      apple_music_tracks =
        tracks_data.map do |track_data|
          ::AppleMusicTrack.create_by_data(track_data)
        end

      isrc = data['relationships']['tracks']['data'].map { |track_data| track_data['attributes']['isrc'] }
      album = ::Album.find_by_isrc(isrc) || ::Album.find_or_initialize_by(upc: data['attributes']['upc'].upcase)

      {
        album: album,
        apple_music_tracks: apple_music_tracks.compact
      }
    end
  end

  def apple_music_playable = playable

  def artwork_l
    @artwork_l ||= build_artwork(640)
  end

  def artwork_m
    @artwork_m ||= build_artwork(300)
  end

  private

  def build_artwork(max_size)
    height = artwork_height > max_size ? max_size : artwork_height
    rate = Float(artwork_height) / Float(artwork_height)
    width = Integer(rate * height)

    url = artwork_url.gsub('{w}', width.to_s).gsub('{h}', height.to_s)

    artwork = ::Artwork.new
    artwork.attributes = { url: url, width: width, height: height }
    artwork
  end
end
