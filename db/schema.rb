# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_16_000000) do

  create_table "album_has_tracks", id: { type: :string, limit: 16 }, charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "album_id", limit: 16, null: false
    t.string "track_id", limit: 16, null: false
    t.index ["album_id", "track_id"], name: "index_album_has_tracks_on_album_id_and_track_id", unique: true
    t.index ["track_id"], name: "fk_rails_00ff058104"
  end

  create_table "albums", id: { type: :string, limit: 16 }, charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0, null: false
    t.datetime "release_date", null: false
    t.integer "total_tracks", default: 0, null: false
    t.integer "pv", default: 0, null: false
    t.integer "popularity", default: 0, null: false
    t.index ["popularity"], name: "index_albums_on_popularity"
    t.index ["release_date"], name: "index_albums_on_release_date"
    t.index ["status"], name: "index_albums_on_status"
    t.index ["total_tracks"], name: "index_albums_on_total_tracks"
  end

  create_table "allowed_actions", id: { type: :string, limit: 16 }, charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "role_id", limit: 16, null: false
    t.string "name", limit: 191, null: false
    t.index ["role_id", "name"], name: "index_allowed_actions_on_role_id_and_name", unique: true
  end

  create_table "apple_music_albums", id: { type: :string, limit: 16 }, charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "album_id", limit: 16, null: false
    t.string "apple_music_id", limit: 191, null: false
    t.string "name", null: false
    t.integer "status", default: 0, null: false
    t.boolean "playable", default: false, null: false, comment: "サブスクリプション再生可能可否"
    t.datetime "release_date", null: false
    t.integer "total_tracks", default: 0, null: false
    t.string "record_label", null: false
    t.string "copyright", null: false
    t.text "artwork_url", null: false
    t.integer "artwork_width", null: false
    t.integer "artwork_height", null: false
    t.string "compacted_id"
    t.index ["album_id"], name: "index_apple_music_albums_on_album_id", unique: true
    t.index ["apple_music_id", "status"], name: "index_apple_music_albums_on_apple_music_id_and_status", unique: true
    t.index ["status"], name: "index_apple_music_albums_on_status"
  end

  create_table "apple_music_artists", id: { type: :string, limit: 16 }, charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "artist_id", limit: 16, null: false
    t.string "apple_music_id", limit: 191, null: false
    t.string "name", limit: 191, null: false
    t.integer "status", default: 0, null: false
    t.index ["apple_music_id"], name: "index_apple_music_artists_on_apple_music_id", unique: true
    t.index ["artist_id"], name: "fk_rails_22b20a7d1a"
    t.index ["status"], name: "index_apple_music_artists_on_status"
  end

  create_table "apple_music_track_words", charset: "utf8mb4", force: :cascade do |t|
    t.string "apple_music_track_id", limit: 16, null: false
    t.string "text", limit: 191, null: false
    t.integer "position", null: false
    t.index ["apple_music_track_id", "position"], name: "index_apple_music_track_words_on_amt_id_and_position", unique: true
    t.index ["text"], name: "index_apple_music_track_words_on_text"
  end

  create_table "apple_music_tracks", id: { type: :string, limit: 16 }, charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "track_id", limit: 16, null: false
    t.string "apple_music_id", limit: 191, null: false
    t.string "apple_music_album_id", limit: 16, null: false
    t.string "isrc", limit: 191, null: false, comment: "国際標準レコーディングコード"
    t.string "name", null: false
    t.integer "disc_number", default: 0, null: false
    t.integer "track_number", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.boolean "playable", default: false, null: false, comment: "サブスクリプション再生可能可否"
    t.boolean "has_lyrics", default: false, null: false, comment: "歌詞有無"
    t.integer "duration_ms", null: false, comment: "再生時間"
    t.text "preview_url"
    t.text "artwork_url", null: false
    t.integer "artwork_width", null: false
    t.integer "artwork_height", null: false
    t.index ["apple_music_album_id", "disc_number", "track_number"], name: "index_apple_music_tracks_on_am_id_and_numbers", unique: true
    t.index ["apple_music_id", "status"], name: "index_apple_music_tracks_on_apple_music_id_and_status", unique: true
    t.index ["disc_number"], name: "index_apple_music_tracks_on_disc_number"
    t.index ["duration_ms"], name: "index_apple_music_tracks_on_duration_ms"
    t.index ["isrc"], name: "index_apple_music_tracks_on_isrc"
    t.index ["name"], name: "index_apple_music_tracks_on_name", length: 191
    t.index ["status"], name: "index_apple_music_tracks_on_status"
    t.index ["track_id"], name: "fk_rails_e512b7f7bc"
    t.index ["track_number"], name: "index_apple_music_tracks_on_track_number"
  end

  create_table "artist_has_albums", id: { type: :string, limit: 16 }, charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "artist_id", limit: 16, null: false
    t.string "album_id", limit: 16, null: false
    t.index ["album_id"], name: "fk_rails_f83ee68a8b"
    t.index ["artist_id", "album_id"], name: "index_artist_has_albums_on_artist_id_and_album_id", unique: true
  end

  create_table "artist_has_tracks", id: { type: :string, limit: 16 }, charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "artist_id", limit: 16, null: false
    t.string "track_id", limit: 16, null: false
    t.index ["artist_id", "track_id"], name: "index_artist_has_tracks_on_artist_id_and_track_id", unique: true
    t.index ["track_id"], name: "fk_rails_720bac58d1"
  end

  create_table "artists", id: { type: :string, limit: 16 }, charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", limit: 191, null: false
    t.integer "status", default: 0, null: false
    t.integer "pv", default: 0, null: false
    t.integer "popularity", default: 0, null: false
    t.index ["name"], name: "index_artists_on_name", unique: true
    t.index ["popularity"], name: "index_artists_on_popularity"
    t.index ["status"], name: "index_artists_on_status"
  end

  create_table "favorites", id: { type: :string, limit: 16 }, charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_id", limit: 16, null: false
    t.string "favorable_id", limit: 16, null: false
    t.string "favorable_type", limit: 191, null: false
    t.index ["favorable_type", "favorable_id", "user_id"], name: "index_favorites_on_favorable_type_and_favorable_id_and_user_id", unique: true
    t.index ["favorable_type", "favorable_id"], name: "index_favorites_on_favorable_type_and_favorable_id"
    t.index ["user_id"], name: "fk_rails_d15744e438"
  end

  create_table "ignore_contents", id: { type: :string, limit: 16 }, charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "music_service_id", limit: 191, null: false
    t.string "title", limit: 191, null: false
    t.text "reason", null: false
    t.index ["music_service_id"], name: "index_ignore_contents_on_music_service_id", unique: true
  end

  create_table "playlist_items", id: { type: :string, limit: 16 }, charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "playlist_id", limit: 16, null: false
    t.string "track_id", limit: 16, null: false
    t.integer "track_number", null: false
    t.index ["playlist_id", "track_number"], name: "index_playlist_items_on_playlist_id_and_track_number", unique: true
    t.index ["track_id"], name: "fk_rails_c2326b5e9c"
  end

  create_table "playlists", id: { type: :string, limit: 16 }, charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "track_id", limit: 16
    t.string "user_id", limit: 16, null: false
    t.string "name", limit: 191, null: false
    t.text "description"
    t.integer "public_type", null: false
    t.integer "popularity", default: 0, null: false
    t.integer "pv", default: 0, null: false
    t.index ["created_at"], name: "index_playlists_on_created_at"
    t.index ["name"], name: "index_playlists_on_name"
    t.index ["popularity"], name: "index_playlists_on_popularity"
    t.index ["track_id"], name: "fk_rails_f42c5216a7"
    t.index ["updated_at"], name: "index_playlists_on_updated_at"
    t.index ["user_id"], name: "fk_rails_d67ef1eb45"
  end

  create_table "public_informations", id: { type: :string, limit: 16 }, charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_id", limit: 16, null: false
    t.integer "public_type", null: false
    t.index ["user_id", "public_type"], name: "index_public_informations_on_user_id_and_public_type", unique: true
  end

  create_table "radio_items", id: { type: :string, limit: 16 }, charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "radio_id", limit: 16, null: false
    t.string "track_id", limit: 16, null: false
    t.integer "track_number", null: false
    t.index ["radio_id", "track_number"], name: "index_radio_items_on_radio_id_and_track_number", unique: true
    t.index ["track_id"], name: "fk_rails_10e11c3a50"
  end

  create_table "radios", id: { type: :string, limit: 16 }, charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "playlist_id", limit: 16, null: false
    t.datetime "start_datetime"
    t.boolean "random", default: false, null: false
    t.integer "popularity", default: 0, null: false
    t.integer "pv", default: 0, null: false
    t.index ["playlist_id"], name: "fk_rails_e10128f920"
    t.index ["popularity"], name: "index_radios_on_popularity"
  end

  create_table "roles", id: { type: :string, limit: 16 }, charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", limit: 191, null: false
    t.string "description", default: "", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "sessions", id: { type: :string, limit: 16 }, charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_id", limit: 16, null: false
    t.string "token", limit: 191, null: false
    t.index ["token"], name: "index_sessions_on_token", unique: true
    t.index ["user_id"], name: "fk_rails_758836b4f0"
  end

  create_table "tracks", id: { type: :string, limit: 16 }, charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "isrc", limit: 191, null: false, comment: "国際標準レコーディングコード"
    t.integer "status", default: 0, null: false
    t.integer "pv", default: 0, null: false
    t.integer "popularity", default: 0, null: false
    t.index ["created_at"], name: "index_tracks_on_created_at"
    t.index ["isrc"], name: "index_tracks_on_isrc", unique: true
    t.index ["popularity"], name: "index_tracks_on_popularity"
    t.index ["status"], name: "index_tracks_on_status"
    t.index ["updated_at"], name: "index_tracks_on_updated_at"
  end

  create_table "users", id: { type: :string, limit: 16 }, charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0, null: false
    t.string "name", limit: 191, null: false
    t.string "username", limit: 191, null: false
    t.string "password_digest", limit: 191
    t.text "description"
    t.string "album_id", limit: 16
    t.string "role_id", limit: 16, null: false
    t.boolean "registered", default: false, null: false
    t.index ["status"], name: "index_users_on_status"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "album_has_tracks", "albums"
  add_foreign_key "album_has_tracks", "tracks"
  add_foreign_key "allowed_actions", "roles"
  add_foreign_key "apple_music_albums", "albums"
  add_foreign_key "apple_music_artists", "artists"
  add_foreign_key "apple_music_track_words", "apple_music_tracks"
  add_foreign_key "apple_music_tracks", "apple_music_albums"
  add_foreign_key "apple_music_tracks", "tracks"
  add_foreign_key "artist_has_albums", "albums"
  add_foreign_key "artist_has_albums", "artists"
  add_foreign_key "artist_has_tracks", "artists"
  add_foreign_key "artist_has_tracks", "tracks"
  add_foreign_key "favorites", "users"
  add_foreign_key "playlist_items", "playlists"
  add_foreign_key "playlist_items", "tracks"
  add_foreign_key "playlists", "tracks"
  add_foreign_key "playlists", "users"
  add_foreign_key "public_informations", "users"
  add_foreign_key "radio_items", "radios"
  add_foreign_key "radio_items", "tracks"
  add_foreign_key "radios", "playlists"
  add_foreign_key "sessions", "users"
end
