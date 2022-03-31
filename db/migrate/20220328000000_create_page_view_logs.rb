# frozen_string_literal: true

class CreatePageViewLogs < ::ActiveRecord::Migration[7.0]
  def change
    create_table(:page_view_logs) do |t|
      t.string(:page_location, null: false, index: true)
      t.integer(:count, null: false)
      t.datetime(:target_date, null: true, index: true)
    end
  end
end
