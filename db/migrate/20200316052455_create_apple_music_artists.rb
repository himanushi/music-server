# frozen_string_literal: true

class CreateAppleMusicArtists < ActiveRecord::Migration[6.0]
  def change
    create_table(:apple_music_artists, id: false) do |t|
      t.string(:id, limit: 16, primary_key: true, null: false)
      t.timestamps
      t.string(:artist_id, limit: 16, null: false)
      t.string(:apple_music_id, limit: 191, null: false)
      t.string(:name, limit: 191, null: false)
      t.integer(:status, null: false, default: 0, index: true)
    end
    add_foreign_key(:apple_music_artists, :artists, dependent: :destroy)
    add_index(:apple_music_artists, :apple_music_id, unique: true)
  end
end
