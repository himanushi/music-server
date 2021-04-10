class ChangeTrackIdToPlaylist < ActiveRecord::Migration[6.0]
  def change
    change_column_null :playlists, :track_id, true
  end
end
