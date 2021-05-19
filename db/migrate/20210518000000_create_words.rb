class CreateWords < ActiveRecord::Migration[6.0]
  def change
    create_table :words do |t|
      t.string     :searchable_id, limit: 16, null: false
      t.string     :searchable_type, limit: 191, null: false
      t.integer    :ngram, null: false
      t.string     :column_name, limit: 191, null: false
      t.string     :text, limit: 16, null: false
      t.integer    :position, null: false
    end
    add_index :words, :column_name
    add_index :words, :text
    add_index :words, :position
    add_index :words, [:searchable_type, :searchable_id]
  end
end
