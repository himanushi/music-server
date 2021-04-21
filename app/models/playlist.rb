class Playlist < ApplicationRecord
  table_id :pst

  belongs_to :user
  belongs_to :track, optional: true
  has_many :playlist_items, dependent: :destroy

  enum public_type: { non_open: 0, open: 1, anonymous_open: 2 }, _prefix: true

  validates :public_type, presence: true
  validates :name,
            presence: true,
            length: { maximum: 100 },
            uniqueness: { case_sensitive: true, message: "がすでに使用されています, 別のタイトルに変更してください" }

  scope :include_users,  -> { eager_load(:user) }
  scope :include_tracks, -> { eager_load(track: [:apple_music_and_itunes_tracks, :spotify_tracks]) }

  class << self
    # 曲存在チェック
    def validate_track_ids(track_ids)
      unless (Track.active.select(:id).find(track_ids).pluck(:id) rescue false)
        raise StandardError, "エラー : 存在しない曲が選択されています"
      end
    end

    # 作者のみ更新可能
    def validate_author(playlist_id, user_id)
      raise StandardError, "エラー : 編集権限がありません" unless find(playlist_id).user_id == user_id
    end

    def upsert(id: nil, track_id:, user_id:, name:, description: nil, public_type:, track_ids: [])
      validate_track_ids(track_ids) if track_ids.present?

      playlist =
        if id.present?
          _playlist = find(id)
          _playlist.track_id = track_id
          _playlist.user_id = user_id
          _playlist.name = name
          _playlist.description = description
          _playlist.public_type = public_type
          _playlist
        else
          new(track_id: track_id, user_id: user_id, name: name, description: description, public_type: public_type)
        end

      ActiveRecord::Base.transaction do
        playlist.playlist_items.destroy

        if track_ids.present?
          items =
            track_ids.map.with_index(1) do |track_id, index|
              PlaylistItem.new(track_id: track_id, track_number: index)
            end
          playlist.playlist_items = items
        end

        playlist.save!
      end

      playlist
    end
  end

  def add_items(track_ids: [])
    self.class.validate_track_ids(track_ids)

    track_number = playlist_items.order(:track_number).last.track_number + 1

    items =
      track_ids.map.with_index(track_number) do |track_id, index|
        PlaylistItem.new(track_id: track_id, track_number: index)
      end

    playlist_items << items

    self
  end
end
