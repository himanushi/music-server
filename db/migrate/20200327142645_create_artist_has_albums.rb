class CreateArtistHasAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :artist_has_albums, id: false do |t|
      t.string     :id, limit: 24, primary_key: true, null: false
      t.timestamps
      t.string     :artist_id, limit: 24, null: false
      t.string     :album_id, limit: 24, null: false
    end
    add_index :artist_has_albums, [:artist_id, :album_id], unique: true
  end
end
