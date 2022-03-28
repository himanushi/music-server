# frozen_string_literal: true

class CreateAppleMusicTracks < ActiveRecord::Migration[6.0]
  def change
    create_table(:apple_music_tracks, id: false) do |t|
      t.string(:id, limit: 16, primary_key: true, null: false)
      t.timestamps
      t.string(:track_id, limit: 16, null: false)
      t.string(:apple_music_id, limit: 191, null: false)
      t.string(:apple_music_album_id, limit: 16, null: false)
      t.string(:isrc, limit: 191, null: false, index: true, comment: '国際標準レコーディングコード')
      t.string(:name, null: false, index: true)
      t.integer(:disc_number, null: false, default: 0, index: true)
      t.integer(:track_number, null: false, default: 0, index: true)
      t.integer(:status, null: false, default: 0, index: true)
      t.boolean(:playable, null: false, default: false, comment: 'サブスクリプション再生可能可否')
      t.boolean(:has_lyrics, null: false, default: false, comment: '歌詞有無')
      t.integer(:duration_ms, null: false, index: true, comment: '再生時間')
      t.text(:preview_url, null: true)
    end
    add_foreign_key(:apple_music_tracks, :tracks)
    add_foreign_key(:apple_music_tracks, :apple_music_albums)
    add_index(:apple_music_tracks, :apple_music_id, unique: true)
    add_index(
      :apple_music_tracks,
      %i[apple_music_album_id disc_number track_number],
      unique: true,
      name: 'index_apple_music_tracks_on_am_id_and_numbers'
    )
  end
end
