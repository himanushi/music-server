# frozen_string_literal: true

class Track < ::ApplicationRecord
  def table_id() = 'trk'

  has_many :artist_has_tracks, dependent: :destroy
  has_many :artists, through: :artist_has_tracks
  has_many :album_has_tracks, dependent: :destroy
  has_many :albums, through: :album_has_tracks
  has_many :apple_music_tracks, dependent: :destroy
  has_one :playlist
  has_many :playlist_items
  has_many :favorites, as: :favorable, dependent: :destroy

  enum status: { pending: 0, active: 1, ignore: 2 }

  delegate :disc_number,
           :track_number,
           :duration_ms,
           :preview_url,
           :apple_music_id,
           :apple_music_playable,
           :name,
           :artwork_m,
           :artwork_l,
           to: :service

  def service() = apple_music_tracks.to_a[0]

  class << self
    def cache?(conditions:)
      cache = true
      cache = false if conditions.key?(:favorite)
      cache = false if conditions.key?(:random)
      cache
    end

    def generate_relation(conditions:, context:)
      conditions = { status: [:active] }.merge(conditions)
      relation = ::Track.includes(:apple_music_tracks)

      relation = relation.where('popularity > 0').active.order('RAND()') if conditions.delete(:random)

      if conditions.key?(:name)
        # @type var name: ::String
        name = conditions.delete(:name)
        relation = relation.where(apple_music_tracks: { id: ::AppleMusicTrackWord.search_ids(name) })
      end

      if conditions.delete(:favorite)
        relation = relation.joins(:favorites).where(favorites: { user_id: context[:current_info][:user].id })
      end

      relation.where(conditions)
    end
  end

  ### Word ###
  # いつか削除したいしモジュールにもしたい
  before_update :upsert_words, if: :status_changed?

  def upsert_words
    ::ActiveRecord::Base.transaction do
      apple_music_tracks.each { |apple_music_track| apple_music_track.upsert_words }
    end
  end
  ### Word ###
end
