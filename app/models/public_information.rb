# ユーザーが公開しても良い情報を保持する
class PublicInformation < ApplicationRecord
  table_id :pif

  belongs_to :user

  enum public_type: { artist: 0, album: 1, track: 2 }
end
