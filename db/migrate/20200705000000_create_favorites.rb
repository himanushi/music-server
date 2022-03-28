# frozen_string_literal: true

class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table(:favorites, id: false) do |t|
      t.string(:id, limit: 16, primary_key: true, null: false)
      t.timestamps
      t.string(:user_id, limit: 16, null: false)
      t.string(:favorable_id, limit: 16, null: false)
      t.string(:favorable_type, limit: 191, null: false)
    end
    add_index(:favorites, %i[favorable_type favorable_id])
    add_index(:favorites, %i[favorable_type favorable_id user_id], unique: true)
    add_foreign_key(:favorites, :users, dependent: :destroy)
  end
end
