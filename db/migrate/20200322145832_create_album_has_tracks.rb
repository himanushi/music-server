# frozen_string_literal: true

class CreateAlbumHasTracks < ActiveRecord::Migration[6.0]
  def change
    create_table(:album_has_tracks, id: false) do |t|
      t.string(:id, limit: 16, primary_key: true, null: false)
      t.timestamps
      t.string(:album_id, limit: 16, null: false)
      t.string(:track_id, limit: 16, null: false)
    end
    add_foreign_key(:album_has_tracks, :albums, dependent: :destroy)
    add_foreign_key(:album_has_tracks, :tracks, dependent: :destroy)
    add_index(:album_has_tracks, %i[album_id track_id], unique: true)
  end
end
