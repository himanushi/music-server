class CreateArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :artists, id: false do |t|
      t.string     :id, limit: 24, primary_key: true, null: false
      t.timestamps
      t.string     :name, limit: 191, null: false
      t.integer    :status, null: false, default: 0, index: true
    end
    add_index :artists, :name, unique: true
  end
end
