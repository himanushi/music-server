class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: false do |t|
      t.string     :id, limit: 24, primary_key: true, null: false
      t.timestamps
      t.string     :name, limit: 191, null: false
      t.text       :description, null: true
      t.string     :album_id, limit: 24, null: true
    end
    add_index :users, :name
  end
end
