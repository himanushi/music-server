# 別々の音楽サービスで同じアルバムのはずが別のアルバムとして識別された時に使用する
# 同じアルバムであるということを登録する
module Albums
  module Mix
    extend ActiveSupport::Concern

    class_methods do
      def mix(main_album_id, sub_album_id)
        main_album = find(main_album_id)
        sub_album  = find(sub_album_id)

        if main_album.apple_music_and_itunes_album.nil?
          main_album.apple_music_and_itunes_album = sub_album.apple_music_and_itunes_album
        end

        if main_album.spotify_album.nil?
          main_album.spotify_album = sub_album.spotify_album
        end

        ActiveRecord::Base.transaction do
          main_album.save!
          sub_album.destroy!
          1/0
        end
      end
    end
  end
end
