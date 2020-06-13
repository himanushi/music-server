# 別々の音楽サービスで同じアルバムのはずが別のアルバムとして識別された時に使用する
# 同じアルバムであるということを登録する
module Albums
  module Mix
    extend ActiveSupport::Concern

    class_methods do
      def mix(main_album_id, sub_album_id)
        first_album = find(main_album_id)
        second_album = find(sub_album_id)

        # トラック数が多いアルバムを正とする
        main_album, sub_album =
          if first_album.total_tracks >= second_album.total_tracks
            [first_album, second_album]
          else
            [second_album, first_album]
          end

        ActiveRecord::Base.transaction do
          if main_album.apple_music_and_itunes_album.nil?
            service_album = sub_album.apple_music_and_itunes_album
            service_album.status = main_album.status
            main_album.apple_music_and_itunes_album = service_album
          end

          if main_album.spotify_album.nil?
            service_album = sub_album.spotify_album
            service_album.status = main_album.status
            main_album.spotify_album = service_album
          end

          # 最新の日時を正とする
          if main_album.release_date <= sub_album.release_date
            main_album.release_date = sub_album.release_date
            main_album.save!
          end

          if sub_album.reload.service.nil?
            sub_album.destroy
          else
            # 現在は2つしか音楽サービスを使っていないのでこちらの分岐にはこない
            # 3つ以上の音楽サービスの場合はありうるはず
            sub_album.ignore!
          end
        end

        main_album
      end

      # トラック数が違う音楽サービスアルバムのみ混合解除する
      # 解除されたアルバムは最新状態で保存される
      def unmix(album_id)
        albums = []
        album = find(album_id)
        albums << album

        ActiveRecord::Base.transaction do
          if (album.apple_music_and_itunes_album.present? &&
              album.total_tracks != album.apple_music_and_itunes_album.total_tracks)
            service_id = album.apple_music_and_itunes_album.apple_music_id
            album.apple_music_and_itunes_album.destroy
            album.reload
            albums << AppleMusicAlbum.create_by_music_service_id(service_id).album
          end

          if (album.spotify_album.present? &&
              album.total_tracks != album.spotify_album.total_tracks)
            service_id = album.spotify_album.spotify_id
            album.spotify_album.destroy
            album.reload
            albums << SpotifyAlbum.create_by_music_service_id(service_id).album
          end
        end

        albums
      end
    end
  end
end
