class CreateAlbumHasTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :album_has_tracks, id: false do |t|
      t.string     :id, limit: 24, primary_key: true, null: false
      t.timestamps
      t.string     :album_id, limit: 24, null: false
      t.string     :track_id, limit: 24, null: false
    end
    add_index :album_has_tracks, [:album_id, :track_id], unique: true
  end
end
