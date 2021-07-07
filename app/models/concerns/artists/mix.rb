# 同じアーティストのはずが別々のアーティストとして識別された時に使用する
# 同じアーティストであるということを登録する
# 全ての音楽サービスのアーティストが結合される
module Artists
  module Mix
    extend ActiveSupport::Concern

    class_methods do
      # 第一引数のIDがメインアーティストとなる
      # 破壊的なメソッドで修正不可なので注意して使用すること
      def mix!(main_artist_id, sub_artist_id)
        Artist.validate_associations([:apple_music_artists, :artist_has_albums, :artist_has_tracks, :favorites])

        main_artist = find(main_artist_id)
        sub_artist = find(sub_artist_id)

        ActiveRecord::Base.transaction do
          # 付け替え
          main_artist.apple_music_artists << sub_artist.apple_music_artists
          main_artist.albums << (sub_artist.albums - main_artist.albums)
          main_artist.tracks << (sub_artist.tracks - main_artist.tracks)
          # サブアーティスト削除
          sub_artist.destroy!
        end

        main_artist.reload
        main_artist
      end
    end
  end
end
