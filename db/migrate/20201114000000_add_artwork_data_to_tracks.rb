class AddArtworkDataToTracks < ActiveRecord::Migration[6.0]
  def up
    # Apple Music
    ActiveRecord::Base.connection.execute(<<~SQL)
      update apple_music_tracks a, (select id, artwork_url, artwork_width, artwork_height from apple_music_albums) t
      set a.artwork_url = t.artwork_url, a.artwork_width = t.artwork_width, a.artwork_height = t.artwork_height
      where a.apple_music_album_id = t.id
    SQL

    # Spotify
    ActiveRecord::Base.connection.execute(<<~SQL)
      update
      spotify_tracks s,
      (
        select id,
        artwork_l_url, artwork_l_width, artwork_l_height,
        artwork_m_url, artwork_m_width, artwork_m_height,
        artwork_s_url, artwork_s_width, artwork_s_height from spotify_albums
      ) t
      set
      s.artwork_l_url = t.artwork_l_url, s.artwork_l_width = t.artwork_l_width, s.artwork_l_height = t.artwork_l_height,
      s.artwork_m_url = t.artwork_m_url, s.artwork_m_width = t.artwork_m_width, s.artwork_m_height = t.artwork_m_height,
      s.artwork_s_url = t.artwork_s_url, s.artwork_s_width = t.artwork_s_width, s.artwork_s_height = t.artwork_s_height
      where s.spotify_album_id = t.id
    SQL
  end

  def down; end
end
