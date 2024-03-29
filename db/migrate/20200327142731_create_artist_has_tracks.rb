# frozen_string_literal: true

class CreateArtistHasTracks < ActiveRecord::Migration[6.0]
  def change
    create_table(:artist_has_tracks, id: false) do |t|
      t.string(:id, limit: 16, primary_key: true, null: false)
      t.timestamps
      t.string(:artist_id, limit: 16, null: false, foreign_key: true)
      t.string(:track_id, limit: 16, null: false, foreign_key: true)
    end
    add_foreign_key(:artist_has_tracks, :artists, dependent: :destroy)
    add_foreign_key(:artist_has_tracks, :tracks, dependent: :destroy)
    add_index(:artist_has_tracks, %i[artist_id track_id], unique: true)
  end
end
