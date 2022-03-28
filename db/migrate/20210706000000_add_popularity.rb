# frozen_string_literal: true

class AddPopularity < ActiveRecord::Migration[6.0]
  def change
    add_column(:albums, :pv, :integer, null: false, default: 0)
    add_column(:artists, :pv, :integer, null: false, default: 0)
    add_column(:tracks, :pv, :integer, null: false, default: 0)
    add_column(:playlists, :pv, :integer, null: false, default: 0)

    add_column(:albums, :popularity, :integer, null: false, default: 0)
    add_column(:artists, :popularity, :integer, null: false, default: 0)
    add_column(:tracks, :popularity, :integer, null: false, default: 0)

    add_index(:albums, :popularity)
    add_index(:artists, :popularity)
    add_index(:tracks, :popularity)
  end
end
