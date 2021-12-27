# frozen_string_literal: true

class UpdateV2 < ::ActiveRecord::Migration[6.0]
  def change
    add_column(:albums, :upc, :string, limit: 191, null: false, index: true, default: false)
  end
end
