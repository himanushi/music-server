class CreateAppleMusicAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :apple_music_albums, id: false do |t|
      t.string     :id, limit: 16, primary_key: true, null: false
      t.timestamps
      t.string     :album_id, limit: 16, null: false
      t.string     :apple_music_id, limit: 191, null: false
      t.string     :name, null: false
      t.integer    :status, null: false, default: 0, index: true
      t.boolean    :playable, null: false, default: false, comment: "サブスクリプション再生可能可否"
      t.datetime   :release_date, null: false
      t.integer    :total_tracks, null: false, default: 0
      t.string     :record_label, null: false
      t.string     :copyright, null: false
      t.text       :artwork_url, null: false
      t.integer    :artwork_width, null: false
      t.integer    :artwork_height,null: false
    end
    add_foreign_key :apple_music_albums, :albums, dependent: :destroy
    add_index :apple_music_albums, :album_id, unique: true
    add_index :apple_music_albums, :apple_music_id, unique: true
  end
end
