# frozen_string_literal: true

class Playlist < ::ApplicationRecord
  def table_id = 'pst'

  belongs_to :user
  belongs_to :track, optional: true
  has_many :playlist_items, dependent: :destroy
  has_one :playlist_condition, dependent: :destroy
  has_many :favorites, as: :favorable, dependent: :destroy

  enum public_type: { non_open: 0, open: 1, anonymous_open: 2 }, _prefix: true

  validates :public_type, presence: true
  validates :name, presence: true, length: { maximum: 30 }

  class << self
    def validate_track_ids!(track_ids)
      # active のみの曲を指定していたが整合性が合わないようなのでDBにあればとりあえずok
      ::Track.find(track_ids)

      true
    end

    def validate_author!(playlist_id, user_id)
      raise(::StandardError, '編集権限がありません') unless find(playlist_id).user_id == user_id

      true
    end

    def create_or_update(
      id:,
      user_id:,
      name:,
      is_condition:,
      description:,
      public_type:,
      track_ids:,
      conditions:
    )
      validate_track_ids!(track_ids) if track_ids.present?

      # @type var playlist: ::Playlist
      playlist =
        if id
          pl = find(id)
          pl.track_id = track_ids.first
          pl.user_id = user_id
          pl.name = name
          pl.description = description
          pl.public_type = public_type
          pl.is_condition = is_condition
          pl
        else
          new(
            track_id: track_ids.first,
            user_id: user_id,
            name: name,
            description: description,
            public_type: public_type,
            is_condition: is_condition
          )
        end

      ::ActiveRecord::Base.transaction do
        playlist.playlist_items.destroy

        if is_condition
          playlist.playlist_condition = ::PlaylistCondition.new(
            order: conditions[:order],
            direction: conditions[:asc] ? 'asc' : 'desc',
            favorite: conditions[:favorite],
            min_popularity: conditions[:min_popularity],
            max_popularity: conditions[:max_popularity]
          )
        end

        if track_ids.present?
          playlist.playlist_items =
            track_ids.map.with_index(1) do |track_id, index|
              ::PlaylistItem.new(track_id: track_id, track_number: index)
            end
        else
          playlist.playlist_items.destroy
        end

        playlist.save!
      end

      playlist
    end

    def cache?(conditions:)
      conditions.present?
      false
    end

    def generate_relation(conditions:, context:)
      conditions = { public_type: %i[open anonymous_open] }.merge(conditions)
      relation = ::Playlist.includes(:user).includes(track: :apple_music_tracks)

      if conditions.delete(:is_mine)
        conditions = conditions.merge({ public_type: %i[open non_open anonymous_open] })
        relation = relation.where(user: context[:current_info][:user])
      end

      if conditions.key?(:name)
        # @type var name: ::String
        name = conditions.delete(:name)
        relation = relation.where('playlists.name like :name', name: "%#{name}%")
      end

      if conditions.delete(:favorite)
        relation = relation.joins(:favorites).where(favorites: { user_id: context[:current_info][:user].id })
      end

      relation.where(conditions)
    end
  end

  def build_condition_items
    return [] unless (condition = playlist_condition)

    track_relation = ::Track.includes(apple_music_tracks: :apple_music_album).where(status: [:active]).limit(100)

    track_relation = track_relation.where('popularity >= ?', condition.min_popularity) if condition.min_popularity
    track_relation = track_relation.where('popularity <= ?', condition.max_popularity) if condition.max_popularity
    track_relation = track_relation.joins(:favorites).where(favorites: { user_id: user_id }) if condition.favorite

    case condition.order
    when 'popularity'
      track_relation = track_relation.order(popularity: condition.direction)
    when 'release_date'
      track_relation = track_relation.order('apple_music_albums.release_date': condition.direction)
    when 'created_at'
      track_relation = track_relation.order('apple_music_albums.created_at': condition.direction)
    end

    track_relation.to_a.map.with_index(1) do |track, index|
      ::PlaylistItem.new(
        track: track,
        track_number: index
      )
    end
  end

  def items
    if is_condition
      build_condition_items
    else
      playlist_items.includes({ track: :apple_music_tracks }).order(:track_number).to_a
    end
  end

  def add_items(track_ids)
    self.class.validate_track_ids!(track_ids)

    track_number = (playlist_items.order(:track_number).last&.track_number || 0) + 1

    # @type var items: ::Array[::PlaylistItem]
    items =
      track_ids.map.with_index(track_number) do |track_id, index|
        ::PlaylistItem.new(track_id: track_id, track_number: index)
      end

    ::ActiveRecord::Base.transaction do
      playlist_items << items
      self.track = playlist_items.first ? playlist_items.first&.track : nil
      touch
      save!
    end

    self
  end

  def to_url
    "#{::ENV['PRODUCTION_APP_URL']}/playlist/#{id}"
  end
end
