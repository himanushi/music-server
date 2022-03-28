# frozen_string_literal: true

class AddCompactedToMusicServiceAlbums < ActiveRecord::Migration[6.0]
  def change
    # アルバム統合判定のため
    add_column(:apple_music_albums, :compacted_id, :string, null: true, index: true)
    add_column(:spotify_albums, :compacted_id, :string, null: true, index: true)
    # アルバムとトラックが重複するのでステータスとサービスIDで一意とする
    remove_index(:apple_music_albums, [:apple_music_id])
    remove_index(:spotify_albums, [:spotify_id])
    add_index(:apple_music_albums, %i[apple_music_id status], unique: true)
    add_index(:spotify_albums, %i[spotify_id status], unique: true)
    remove_index(:apple_music_tracks, [:apple_music_id])
    remove_index(:spotify_tracks, [:spotify_id])
    add_index(:apple_music_tracks, %i[apple_music_id status], unique: true)
    add_index(:spotify_tracks, %i[spotify_id status], unique: true)
  end
end
