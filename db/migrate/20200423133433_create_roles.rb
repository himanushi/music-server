class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles, id: false do |t|
      t.string     :id, limit: 24, primary_key: true, null: false
      t.timestamps
      t.string     :name, limit: 191, null: false
      t.text       :description, null: true
    end
  end
end
