# frozen_string_literal: true

class DropSpotify < ActiveRecord::Migration[6.0]
  def change
    drop_table('spotify_track_words', charset: 'utf8mb4', force: :cascade) do |t|
      t.string('spotify_track_id', limit: 16, null: false)
      t.string('text', limit: 191, null: false)
      t.integer('position', null: false)
      t.index(%w[spotify_track_id position], name: 'index_spotify_track_words_on_st_id_and_position', unique: true)
      t.index(['text'], name: 'index_spotify_track_words_on_text')
    end

    drop_table('spotify_tracks', id: { type: :string, limit: 16 }, charset: 'utf8mb4', force: :cascade) do |t|
      t.datetime('created_at', precision: 6, null: false)
      t.datetime('updated_at', precision: 6, null: false)
      t.string('track_id', limit: 16, null: false)
      t.string('spotify_id', limit: 191, null: false)
      t.string('spotify_album_id', limit: 16, null: false)
      t.string('isrc', limit: 191, null: false, comment: '国際標準レコーディングコード')
      t.string('name', null: false)
      t.integer('disc_number', default: 0, null: false)
      t.integer('track_number', default: 0, null: false)
      t.integer('status', default: 0, null: false)
      t.boolean('playable', default: false, null: false, comment: 'サブスクリプション再生可能可否')
      t.boolean('has_lyrics', default: false, null: false, comment: '歌詞有無')
      t.integer('duration_ms', null: false, comment: '再生時間')
      t.text('preview_url')
      t.integer('popularity', default: 0, null: false)
      t.text('artwork_l_url')
      t.integer('artwork_l_width')
      t.integer('artwork_l_height')
      t.text('artwork_m_url')
      t.integer('artwork_m_width')
      t.integer('artwork_m_height')
      t.text('artwork_s_url')
      t.integer('artwork_s_width')
      t.integer('artwork_s_height')
      t.index(['disc_number'], name: 'index_spotify_tracks_on_disc_number')
      t.index(['duration_ms'], name: 'index_spotify_tracks_on_duration_ms')
      t.index(['isrc'], name: 'index_spotify_tracks_on_isrc')
      t.index(['name'], name: 'index_spotify_tracks_on_name', length: 191)
      t.index(['popularity'], name: 'index_spotify_tracks_on_popularity')
      t.index(
        %w[spotify_album_id disc_number track_number],
        name: 'index_spotify_tracks_on_sp_id_and_numbers',
        unique: true
      )
      t.index(%w[spotify_id status], name: 'index_spotify_tracks_on_spotify_id_and_status', unique: true)
      t.index(['status'], name: 'index_spotify_tracks_on_status')
      t.index(['track_id'], name: 'fk_rails_5fc39ad240')
      t.index(['track_number'], name: 'index_spotify_tracks_on_track_number')
    end

    drop_table('spotify_albums', id: { type: :string, limit: 16 }, charset: 'utf8mb4', force: :cascade) do |t|
      t.datetime('created_at', precision: 6, null: false)
      t.datetime('updated_at', precision: 6, null: false)
      t.string('album_id', limit: 16, null: false)
      t.string('spotify_id', limit: 191, null: false)
      t.string('name', null: false)
      t.integer('status', default: 0, null: false)
      t.datetime('release_date', null: false)
      t.integer('total_tracks', default: 0, null: false)
      t.string('record_label', null: false)
      t.string('copyright', null: false)
      t.string('upc')
      t.text('artwork_l_url')
      t.integer('artwork_l_width')
      t.integer('artwork_l_height')
      t.text('artwork_m_url')
      t.integer('artwork_m_width')
      t.integer('artwork_m_height')
      t.text('artwork_s_url')
      t.integer('artwork_s_width')
      t.integer('artwork_s_height')
      t.integer('popularity', default: 0, null: false)
      t.string('compacted_id')
      t.index(['album_id'], name: 'index_spotify_albums_on_album_id', unique: true)
      t.index(['popularity'], name: 'index_spotify_albums_on_popularity')
      t.index(%w[spotify_id status], name: 'index_spotify_albums_on_spotify_id_and_status', unique: true)
      t.index(['status'], name: 'index_spotify_albums_on_status')
    end

    drop_table('spotify_artists', id: { type: :string, limit: 16 }, charset: 'utf8mb4', force: :cascade) do |t|
      t.datetime('created_at', precision: 6, null: false)
      t.datetime('updated_at', precision: 6, null: false)
      t.string('artist_id', limit: 16, null: false)
      t.string('spotify_id', limit: 191, null: false)
      t.string('name', limit: 191, null: false)
      t.integer('status', default: 0, null: false)
      t.integer('total_followers', default: 0, null: false)
      t.text('artwork_l_url')
      t.integer('artwork_l_width')
      t.integer('artwork_l_height')
      t.text('artwork_m_url')
      t.integer('artwork_m_width')
      t.integer('artwork_m_height')
      t.text('artwork_s_url')
      t.integer('artwork_s_width')
      t.integer('artwork_s_height')
      t.integer('popularity', default: 0, null: false)
      t.index(['artist_id'], name: 'fk_rails_d3df77c05c')
      t.index(['popularity'], name: 'index_spotify_artists_on_popularity')
      t.index(['spotify_id'], name: 'index_spotify_artists_on_spotify_id', unique: true)
      t.index(['status'], name: 'index_spotify_artists_on_status')
      t.index(['total_followers'], name: 'index_spotify_artists_on_total_followers')
    end
  end
end
