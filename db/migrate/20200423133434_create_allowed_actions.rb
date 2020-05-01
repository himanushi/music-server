class CreateAllowedActions < ActiveRecord::Migration[6.0]
  def change
    create_table :allowed_actions, id: false do |t|
      t.string     :id, limit: 16, primary_key: true, null: false
      t.timestamps
      t.string     :role_id, limit: 16, null: false
      t.string     :name, limit: 191, null: false
    end
    add_foreign_key :allowed_actions, :roles, dependent: :destroy
    add_index :allowed_actions, [:role_id, :name], unique: true
  end
end
