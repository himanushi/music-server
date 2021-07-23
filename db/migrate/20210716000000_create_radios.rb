class CreateRadios < ActiveRecord::Migration[6.0]
  def change
    create_table :radios, id: false do |t|
      t.string     :id, limit: 16, primary_key: true, null: false
      t.timestamps
      t.string     :playlist_id, limit: 16, null: false
      t.integer    :current_playback_no, null: true
      t.datetime   :start_datetime, null: true
      t.integer    :public_type, null: false, default: 0
      t.integer    :status, null: false, default: 0
      t.boolean    :random, null: false, default: false
      t.boolean    :repeat, null: false, default: false
    end
    add_foreign_key :radios, :playlists
    add_index :radios, :status

    create_table :radio_items, id: false do |t|
      t.string     :id, limit: 16, primary_key: true, null: false
      t.timestamps
      t.string     :radio_id, limit: 16, null: false
      t.string     :track_id, limit: 16, null: false
      t.integer    :track_number, null: false
    end
    add_foreign_key :radio_items, :radios
    add_foreign_key :radio_items, :tracks
    add_index :radio_items, [:radio_id, :track_number], unique: true
  end
end
