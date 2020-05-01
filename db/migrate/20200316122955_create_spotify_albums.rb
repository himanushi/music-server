class CreateSpotifyAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :spotify_albums, id: false do |t|
      t.string     :id, limit: 16, primary_key: true, null: false
      t.timestamps
      t.string     :album_id, limit: 16, null: false
      t.string     :spotify_id, limit: 191, null: false
      t.string     :name, null: false
      t.integer    :status, null: false, default: 0, index: true
      t.datetime   :release_date, null: false
      t.integer    :total_tracks, null: false, default: 0
      t.string     :record_label, null: false
      t.string     :copyright, null: false
      t.string     :upc, null: true
      t.text       :artwork_l_url, null: true
      t.integer    :artwork_l_width, null: true
      t.integer    :artwork_l_height,null: true
      t.text       :artwork_m_url, null: true
      t.integer    :artwork_m_width, null: true
      t.integer    :artwork_m_height,null: true
      t.text       :artwork_s_url, null: true
      t.integer    :artwork_s_width, null: true
      t.integer    :artwork_s_height,null: true
      t.integer    :popularity, null: false, default: 0, index: true
    end
    add_foreign_key :spotify_albums, :albums, dependent: :destroy
    add_index :spotify_albums, :album_id, unique: true
    add_index :spotify_albums, :spotify_id, unique: true
  end
end
