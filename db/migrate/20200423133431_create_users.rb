class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: false do |t|
      t.string     :id, limit: 24, primary_key: true, null: false
      t.timestamps
      t.integer    :status, null: false, default: 0, index: true
      t.string     :name, limit: 191, null: false
      t.string     :username, limit: 191, null: false
      t.string     :encrypted_password, limit: 191, null: true
      t.string     :token, limit: 191, null: false
      t.text       :description, null: true
      t.string     :album_id, limit: 24, null: true
    end
    add_index :users, :username, unique: true
    add_index :users, :token, unique: true
  end
end
