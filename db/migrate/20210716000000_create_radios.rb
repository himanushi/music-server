# frozen_string_literal: true

class CreateRadios < ActiveRecord::Migration[6.0]
  def change
    create_table(:radios, id: false) do |t|
      t.string(:id, limit: 16, primary_key: true, null: false)
      t.timestamps
      t.string(:playlist_id, limit: 16, null: false)
      t.datetime(:start_datetime, null: true)
      t.boolean(:random, null: false, default: false)
      t.integer(:popularity, null: false, default: 0, index: true)
      t.integer(:pv, null: false, default: 0)
    end
    add_foreign_key(:radios, :playlists)

    create_table(:radio_items, id: false) do |t|
      t.string(:id, limit: 16, primary_key: true, null: false)
      t.timestamps
      t.string(:radio_id, limit: 16, null: false)
      t.string(:track_id, limit: 16, null: false)
      t.integer(:track_number, null: false)
    end
    add_foreign_key(:radio_items, :radios)
    add_foreign_key(:radio_items, :tracks)
    add_index(:radio_items, %i[radio_id track_number], unique: true)
  end
end
