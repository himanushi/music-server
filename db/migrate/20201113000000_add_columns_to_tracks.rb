# frozen_string_literal: true

class AddColumnsToTracks < ActiveRecord::Migration[6.0]
  def change
    add_column(:apple_music_tracks, :artwork_url, :text, null: false)
    add_column(:apple_music_tracks, :artwork_width, :integer, null: false)
    add_column(:apple_music_tracks, :artwork_height, :integer, null: false)

    add_column(:spotify_tracks, :artwork_l_url, :text, null: true)
    add_column(:spotify_tracks, :artwork_l_width, :integer, null: true)
    add_column(:spotify_tracks, :artwork_l_height, :integer, null: true)
    add_column(:spotify_tracks, :artwork_m_url, :text, null: true)
    add_column(:spotify_tracks, :artwork_m_width, :integer, null: true)
    add_column(:spotify_tracks, :artwork_m_height, :integer, null: true)
    add_column(:spotify_tracks, :artwork_s_url, :text, null: true)
    add_column(:spotify_tracks, :artwork_s_width, :integer, null: true)
    add_column(:spotify_tracks, :artwork_s_height, :integer, null: true)
  end
end
