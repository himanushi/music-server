# frozen_string_literal: true

class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table(:roles, id: false) do |t|
      t.string(:id, limit: 16, primary_key: true, null: false)
      t.timestamps
      t.string(:name, limit: 191, null: false)
      t.string(:description, null: false, default: '')
    end
    add_index(:roles, :name, unique: true)
  end
end
