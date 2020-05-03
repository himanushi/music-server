class CreateArtistHasAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :artist_has_albums, id: false do |t|
      t.string     :id, limit: 16, primary_key: true, null: false
      t.timestamps
      t.string     :artist_id, limit: 16, null: false
      t.string     :album_id, limit: 16, null: false
    end
    add_foreign_key :artist_has_albums, :artists, dependent: :destroy
    add_foreign_key :artist_has_albums, :albums, dependent: :destroy
    add_index :artist_has_albums, [:artist_id, :album_id], unique: true
  end
end
