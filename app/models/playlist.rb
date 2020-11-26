class Playlist < ApplicationRecord
  table_id :pst

  belongs_to :user
  belongs_to :track
  has_many :playlist_items, dependent: :destroy

  enum public_type: { non_open: 0, open: 1 }

  validates :public_type, presence: true
  validates :name,
            presence: true,
            length: { maximum: 15 },
            uniqueness: { case_sensitive: true, message: "がすでに使用されています, 別のタイトルに変更してください" }

  class << self
    # 曲存在チェック
    def validate_track_ids(track_ids)
      unless (Track.select(:id).find(track_ids).pluck(:id) rescue false)
        raise StandardError, "エラー : 存在しない曲が選択されています"
      end
    end

    def upsert(id: nil, track_id:, user_id:, name:, description: nil, public_type:, track_ids: [])
      raise StandardError, "エラー : プレイリストは1曲以上必要です" unless track_ids.present?
      validate_track_ids(track_ids)

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

      items =
        track_ids.map.with_index(1) do |track_id, index|
          PlaylistItem.new(track_id: track_id, track_number: index)
        end

      ActiveRecord::Base.transaction do
        playlist.playlist_items.destroy
        playlist.playlist_items = items
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
