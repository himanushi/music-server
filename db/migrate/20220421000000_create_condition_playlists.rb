# frozen_string_literal: true

class CreateConditionPlaylists < ::ActiveRecord::Migration[7.0]
  def change
    add_column(:playlists, :is_condition, :boolean, null: false, index: true, default: false)

    create_table(:playlist_conditions) do |t|
      t.string(:playlist_id, limit: 16, null: false)
      t.integer(:order, null: false)
      t.integer(:direction, null: false)
      t.boolean(:favorite, null: false, default: false)
      t.integer(:min_popularity, null: true)
      t.integer(:max_popularity, null: true)
      t.datetime(:from_release_date, null: true)
      t.datetime(:to_release_date, null: true)
    end
    add_foreign_key(:playlist_conditions, :playlists)
  end
end
