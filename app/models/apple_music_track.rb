# frozen_string_literal: true

class AppleMusicTrack < ::ApplicationRecord
  def table_id = 'amt'

  belongs_to :apple_music_album
  belongs_to :track

  delegate :status, :popularity, to: :track

  ### Word ###
  # いつか削除したいしモジュールにもしたい
  has_many :words, class_name: 'AppleMusicTrackWord', dependent: :destroy

  def build_words_attributes
    ::AppleMusicTrackWord.bigram_attributes(id, name)
  end

  def upsert_words
    # 2文字未満は検索しないので除外
    return unless name.length > 1

    ::ActiveRecord::Base.transaction do
      words.delete_all
      ::AppleMusicTrackWord.insert_all(build_words_attributes) if status == 'active'
    end
  end
  ### Word ###

  class << self
    def create_by_data(data)
      new(mapping(data).merge(mapping_relation(data)))
    end

    def mapping(data)
      attrs = data['attributes']

      if (preview = attrs['previews'].first)
        url = preview['url']
      end

      artwork = attrs['artwork']

      {
        apple_music_id: data['id'],
        name: (attrs['name'] || '')[..254] || '',
        playable: attrs['playParams'].present?,
        isrc: attrs['isrc'].upcase,
        disc_number: attrs['discNumber'],
        track_number: attrs['trackNumber'],
        has_lyrics: attrs['hasLyrics'],
        duration_ms: attrs['durationInMillis'],
        preview_url: url,
        artwork_url: artwork['url'],
        artwork_width: artwork['width'],
        artwork_height: artwork['height']
      }
    end

    def mapping_relation(data)
      attrs = data['attributes']
      isrc = attrs['isrc'].upcase
      track = ::Track.find_by!(isrc: isrc)

      {
        track: track
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
