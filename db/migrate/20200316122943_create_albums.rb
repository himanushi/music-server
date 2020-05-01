class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums, id: false do |t|
      t.string     :id, limit: 16, primary_key: true, null: false
      t.timestamps
      t.integer    :status, null: false, default: 0, index: true
      t.datetime   :release_date, null: false, index: true
      t.integer    :total_tracks, null: false, default: 0, index: true
    end
  end
end
