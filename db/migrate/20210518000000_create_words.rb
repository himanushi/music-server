class CreateWords < ActiveRecord::Migration[6.0]
  def change
    create_table :apple_music_track_words do |t|
      t.string     :apple_music_track_id, limit: 16, null: false
      t.string     :text, limit: 191, null: false
      t.integer    :position, null: false
    end
    add_foreign_key :apple_music_track_words, :apple_music_tracks
    add_index :apple_music_track_words, :text
    add_index :apple_music_track_words, [:apple_music_track_id, :position], unique: true, name: 'index_apple_music_track_words_on_amt_id_and_position'

    create_table :spotify_track_words do |t|
      t.string     :spotify_track_id, limit: 16, null: false
      t.string     :text, limit: 191, null: false
      t.integer    :position, null: false
    end
    add_foreign_key :spotify_track_words, :spotify_tracks
    add_index :spotify_track_words, :text
    add_index :spotify_track_words, [:spotify_track_id, :position], unique: true, name: 'index_spotify_track_words_on_st_id_and_position'
  end
end
