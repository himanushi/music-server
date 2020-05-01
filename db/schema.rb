# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_23_133434) do

  create_table "album_has_tracks", id: :string, limit: 16, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "album_id", limit: 16, null: false
    t.string "track_id", limit: 16, null: false
    t.index ["album_id", "track_id"], name: "index_album_has_tracks_on_album_id_and_track_id", unique: true
  end

  create_table "albums", id: :string, limit: 16, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0, null: false
    t.datetime "release_date", null: false
    t.integer "total_tracks", default: 0, null: false
    t.index ["release_date"], name: "index_albums_on_release_date"
    t.index ["status"], name: "index_albums_on_status"
    t.index ["total_tracks"], name: "index_albums_on_total_tracks"
  end

  create_table "allowed_actions", id: :string, limit: 16, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "role_id", limit: 16, null: false
    t.string "name", limit: 191, null: false
    t.index ["role_id", "name"], name: "index_allowed_actions_on_role_id_and_name", unique: true
  end

  create_table "apple_music_albums", id: :string, limit: 16, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
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

  create_table "apple_music_artists", id: :string, limit: 16, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
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

  create_table "apple_music_tracks", id: :string, limit: 16, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
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

  create_table "artist_has_albums", id: :string, limit: 16, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "artist_id", limit: 16, null: false
    t.string "album_id", limit: 16, null: false
    t.index ["artist_id", "album_id"], name: "index_artist_has_albums_on_artist_id_and_album_id", unique: true
  end

  create_table "artist_has_tracks", id: :string, limit: 16, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "artist_id", limit: 16, null: false
    t.string "track_id", limit: 16, null: false
    t.index ["artist_id", "track_id"], name: "index_artist_has_tracks_on_artist_id_and_track_id", unique: true
  end

  create_table "artists", id: :string, limit: 16, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", limit: 191, null: false
    t.integer "status", default: 0, null: false
    t.index ["name"], name: "index_artists_on_name", unique: true
    t.index ["status"], name: "index_artists_on_status"
  end

  create_table "roles", id: :string, limit: 16, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", limit: 191, null: false
    t.string "description", default: "", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "sessions", id: :string, limit: 16, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_id", limit: 16, null: false
    t.string "token", limit: 191, null: false
    t.index ["token"], name: "index_sessions_on_token", unique: true
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "spotify_albums", id: :string, limit: 16, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "album_id", limit: 16, null: false
    t.string "spotify_id", limit: 191, null: false
    t.string "name", null: false
    t.integer "status", default: 0, null: false
    t.datetime "release_date", null: false
    t.integer "total_tracks", default: 0, null: false
    t.string "record_label", null: false
    t.string "copyright", null: false
    t.string "upc"
    t.text "artwork_l_url"
    t.integer "artwork_l_width"
    t.integer "artwork_l_height"
    t.text "artwork_m_url"
    t.integer "artwork_m_width"
    t.integer "artwork_m_height"
    t.text "artwork_s_url"
    t.integer "artwork_s_width"
    t.integer "artwork_s_height"
    t.integer "popularity", default: 0, null: false
    t.string "compacted_id"
    t.index ["album_id"], name: "index_spotify_albums_on_album_id", unique: true
    t.index ["popularity"], name: "index_spotify_albums_on_popularity"
    t.index ["spotify_id", "status"], name: "index_spotify_albums_on_spotify_id_and_status", unique: true
    t.index ["status"], name: "index_spotify_albums_on_status"
  end

  create_table "spotify_artists", id: :string, limit: 16, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "artist_id", limit: 16, null: false
    t.string "spotify_id", limit: 191, null: false
    t.string "name", limit: 191, null: false
    t.integer "status", default: 0, null: false
    t.integer "total_followers", default: 0, null: false
    t.text "artwork_l_url"
    t.integer "artwork_l_width"
    t.integer "artwork_l_height"
    t.text "artwork_m_url"
    t.integer "artwork_m_width"
    t.integer "artwork_m_height"
    t.text "artwork_s_url"
    t.integer "artwork_s_width"
    t.integer "artwork_s_height"
    t.integer "popularity", default: 0, null: false
    t.index ["artist_id"], name: "fk_rails_d3df77c05c"
    t.index ["popularity"], name: "index_spotify_artists_on_popularity"
    t.index ["spotify_id"], name: "index_spotify_artists_on_spotify_id", unique: true
    t.index ["status"], name: "index_spotify_artists_on_status"
    t.index ["total_followers"], name: "index_spotify_artists_on_total_followers"
  end

  create_table "spotify_tracks", id: :string, limit: 16, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "track_id", limit: 16, null: false
    t.string "spotify_id", limit: 191, null: false
    t.string "spotify_album_id", limit: 16, null: false
    t.string "isrc", limit: 191, null: false, comment: "国際標準レコーディングコード"
    t.string "name", null: false
    t.integer "disc_number", default: 0, null: false
    t.integer "track_number", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.boolean "playable", default: false, null: false, comment: "サブスクリプション再生可能可否"
    t.boolean "has_lyrics", default: false, null: false, comment: "歌詞有無"
    t.integer "duration_ms", null: false, comment: "再生時間"
    t.text "preview_url"
    t.integer "popularity", default: 0, null: false
    t.index ["disc_number"], name: "index_spotify_tracks_on_disc_number"
    t.index ["duration_ms"], name: "index_spotify_tracks_on_duration_ms"
    t.index ["isrc"], name: "index_spotify_tracks_on_isrc"
    t.index ["name"], name: "index_spotify_tracks_on_name", length: 191
    t.index ["popularity"], name: "index_spotify_tracks_on_popularity"
    t.index ["spotify_album_id", "disc_number", "track_number"], name: "index_spotify_tracks_on_sp_id_and_numbers", unique: true
    t.index ["spotify_id", "status"], name: "index_spotify_tracks_on_spotify_id_and_status", unique: true
    t.index ["status"], name: "index_spotify_tracks_on_status"
    t.index ["track_id"], name: "fk_rails_5fc39ad240"
    t.index ["track_number"], name: "index_spotify_tracks_on_track_number"
  end

  create_table "tracks", id: :string, limit: 16, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "isrc", limit: 191, null: false, comment: "国際標準レコーディングコード"
    t.integer "status", default: 0, null: false
    t.index ["created_at"], name: "index_tracks_on_created_at"
    t.index ["isrc"], name: "index_tracks_on_isrc", unique: true
    t.index ["status"], name: "index_tracks_on_status"
    t.index ["updated_at"], name: "index_tracks_on_updated_at"
  end

  create_table "users", id: :string, limit: 16, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0, null: false
    t.string "name", limit: 191, null: false
    t.string "username", limit: 191, null: false
    t.string "encrypted_password", limit: 191
    t.text "description"
    t.string "album_id", limit: 16
    t.string "role_id", limit: 16, null: false
    t.index ["status"], name: "index_users_on_status"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "allowed_actions", "roles"
  add_foreign_key "apple_music_albums", "albums"
  add_foreign_key "apple_music_artists", "artists"
  add_foreign_key "apple_music_tracks", "apple_music_albums"
  add_foreign_key "apple_music_tracks", "tracks"
  add_foreign_key "spotify_albums", "albums"
  add_foreign_key "spotify_artists", "artists"
  add_foreign_key "spotify_tracks", "spotify_albums"
  add_foreign_key "spotify_tracks", "tracks"
end
