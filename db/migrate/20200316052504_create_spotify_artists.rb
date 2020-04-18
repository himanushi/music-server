class CreateSpotifyArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :spotify_artists, id: false do |t|
      t.string     :id, limit: 24, primary_key: true, null: false
      t.timestamps
      t.string     :artist_id, limit: 24, null: false
      t.string     :spotify_id, limit: 191, null: false
      t.string     :name, limit: 191, null: false
      t.integer    :status, null: false, default: 0, index: true
      t.integer    :total_followers, null: false, default: 0, index: true
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
    add_foreign_key :spotify_artists, :artists, dependent: :destroy
    add_index :spotify_artists, :spotify_id, unique: true
  end
end
