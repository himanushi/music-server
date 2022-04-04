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

    begin
      ::AllowedAction.where(
        name: %w[
          changeStatus
          compactAlbum
          createRadio
          deleteRadio
          generateSitemaps
          mixAlbum
          mixArtist
          radio
          radios
          tally
          uncompactAlbum
          unmixAlbum
          updateAnalytics
          upsertAlbum
          upsertArtist
          upsertRole
        ]
      ).delete_all
      ::AllowedAction.new(name: 'updateRole', role: ::Role.admin).save!
      ::AllowedAction.new(name: 'allActions', role: ::Role.admin).save!
    rescue StandardError => e
    end
  end

  def down
    raise(::ActiveRecord::IrreversibleMigration)
  end
end
