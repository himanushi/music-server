# frozen_string_literal: true

class UpdateV2 < ::ActiveRecord::Migration[6.0]
  def up
    add_column(:albums, :upc, :string, limit: 191, null: false, index: true, default: '')

    add_column(:apple_music_albums, :upc, :string, limit: 191, null: false, index: true, default: '')
    remove_column(:apple_music_albums, :status, :compacted_id)

    remove_column(:apple_music_artists, :status)

    remove_column(:ignore_contents, :title)

    drop_table(:public_informations)

    drop_table(:radio_items)

    drop_table(:radios)
  end

  def down
    raise(::ActiveRecord::IrreversibleMigration)
  end
end
