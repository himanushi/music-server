# frozen_string_literal: true

class CreateIgnoreContents < ActiveRecord::Migration[6.0]
  def change
    create_table(:ignore_contents, id: false) do |t|
      t.string(:id, limit: 16, primary_key: true, null: false)
      t.timestamps
      t.string(:music_service_id, limit: 191, null: false)
      t.string(:title, limit: 191, null: false)
      t.text(:reason, null: false)
    end
    add_index(:ignore_contents, :music_service_id, unique: true)
  end
end
