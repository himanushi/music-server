class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions, id: false do |t|
      t.string     :id, limit: 16, primary_key: true, null: false
      t.timestamps
      t.string     :user_id, limit: 16, null: false
      t.string     :token, limit: 191, null: false
    end
    add_foreign_key :sessions, :users, dependent: :destroy
    add_index :sessions, :token, unique: true
  end
end
