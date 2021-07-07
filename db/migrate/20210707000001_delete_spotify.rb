class DeleteSpotify < ActiveRecord::Migration[6.0]
  def change
    delete_sql = <<~SQL
      DELETE FROM album_has_tracks WHERE track_id in (select m.id as id from tracks m left join apple_music_tracks a on m.id = a.track_id where a.id is null);
      DELETE FROM album_has_tracks WHERE album_id in (select m.id as id from albums m left join apple_music_albums a on m.id = a.album_id where a.id is null);
      DELETE FROM artist_has_tracks WHERE track_id in (select m.id as id from tracks m left join apple_music_tracks a on m.id = a.track_id where a.id is null);
      DELETE FROM artist_has_tracks WHERE artist_id in (select m.id as id from artists m left join apple_music_artists a on m.id = a.artist_id where a.id is null);
      DELETE FROM artist_has_albums WHERE artist_id in (select m.id as id from artists m left join apple_music_artists a on m.id = a.artist_id where a.id is null);
      DELETE FROM artist_has_albums WHERE album_id in (select m.id as id from albums m left join apple_music_albums a on m.id = a.album_id where a.id is null);
      DELETE FROM tracks WHERE id in (select m.id from (select * from tracks) m left join apple_music_tracks a on m.id = a.track_id where a.id is null);
      DELETE FROM albums WHERE id in (select m.id from (select * from albums) m left join apple_music_albums a on m.id = a.album_id where a.id is null);
      DELETE FROM artists WHERE id in (select m.id from (select * from artists) m left join apple_music_artists a on m.id = a.artist_id where a.id is null);
    SQL

    delete_sql.split("\n").each do |sql|
      ActiveRecord::Base.connection.execute(sql)
    end
  end
end
