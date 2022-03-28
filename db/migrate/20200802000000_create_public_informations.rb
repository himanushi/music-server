# frozen_string_literal: true

class CreatePublicInformations < ActiveRecord::Migration[6.0]
  def change
    create_table(:public_informations, id: false) do |t|
      t.string(:id, limit: 16, primary_key: true, null: false)
      t.timestamps
      t.string(:user_id, limit: 16, null: false)
      t.integer(:public_type, null: false)
    end
    add_foreign_key(:public_informations, :users, dependent: :destroy)
    add_index(:public_informations, %i[user_id public_type], unique: true)
  end
end
