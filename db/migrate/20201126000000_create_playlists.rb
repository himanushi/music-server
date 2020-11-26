class CreatePlaylists < ActiveRecord::Migration[6.0]
  def change
    create_table :playlists, id: false do |t|
      t.string     :id, limit: 16, primary_key: true, null: false
      t.timestamps
      t.string     :track_id, limit: 16, null: false
      t.string     :user_id, limit: 16, null: false
      t.string     :name, limit: 191, null: false
      t.text       :description, null: true
      t.integer    :public_type, null: false
      t.integer    :popularity, null: false, default: 0, index: true
    end
    add_foreign_key :playlists, :tracks
    add_foreign_key :playlists, :users
    add_index :playlists, :name, unique: true
    add_index :playlists, :created_at
    add_index :playlists, :updated_at

    create_table :playlist_items, id: false do |t|
      t.string     :id, limit: 16, primary_key: true, null: false
      t.timestamps
      t.string     :playlist_id, limit: 16, null: false
      t.string     :track_id, limit: 16, null: false
      t.integer    :track_number, null: false
    end
    add_foreign_key :playlist_items, :playlists
    add_foreign_key :playlist_items, :tracks
    add_index :playlist_items, [:playlist_id, :track_number], unique: true
  end
end
