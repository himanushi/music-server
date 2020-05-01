class CreateTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :tracks, id: false do |t|
      t.string     :id, limit: 16, primary_key: true, null: false
      t.timestamps
      t.string     :isrc, limit: 191, null: false, comment: "国際標準レコーディングコード"
      t.integer    :status, null: false, default: 0, index: true
    end
    add_index :tracks, :isrc, unique: true
    add_index :tracks, :created_at
    add_index :tracks, :updated_at
  end
end
