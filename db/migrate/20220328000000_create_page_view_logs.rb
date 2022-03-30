# frozen_string_literal: true

class CreateActionLogs < ::ActiveRecord::Migration[7.0]
  def change
    create_table(:page_view_logs) do |t|
      t.timestamps
      t.string(:path_location, null: false)
      t.string(:count, null: false)
    end
  end
end
