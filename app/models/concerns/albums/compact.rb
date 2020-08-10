module Albums
  module Compact
    extend ActiveSupport::Concern

    module ClassMethods
      # 複数アルバムを単一アルバムへ統合する
      def compact(name, ids)
        ids.each do |id|
          raise StandardError, "TTIDが違う" unless TTID.to_hash(id)[:table_id] == self.table_id
        end

        music_service_albums = where(id: ids)

        music_service_albums.each do |music_service_album|
          raise StandardError, "compacted_id が存在するのでダメ!統合解除とかして対応すべし。" unless music_service_album.compacted_id.nil?
        end

        ignore_attr_names = %w[id created_at updated_at]

        music_service_album_attrs =
          music_service_albums.first.attributes.except(*ignore_attr_names).symbolize_keys

        music_service_album_attrs.merge!({
          name: name,
          status: :pending,
        })

        # トラック統合
        music_service_track_table_name = self.name.underscore.gsub(/album\z/, "tracks")
        isrc = []
        music_service_tracks_attrs =
          music_service_albums.map.with_index(1) do |album, disc_number|
            album.__send__(music_service_track_table_name).map do |track|
              # ISRC が被ることはほぼないが被った場合は先勝ちとする
              # TODO: 欠損する可能性があるのをなんとかする
              next if isrc.include?(track.isrc)
              isrc << track.isrc

              music_service_track_attrs =
                track.attributes.except(*ignore_attr_names, "#{self.name.underscore}_id").symbolize_keys
              music_service_track_attrs.merge!({
                disc_number: disc_number,
                status: :pending,
              })
            end
          end.flatten.compact

        music_service_track_class = music_service_track_table_name.classify.constantize
        music_service_tracks = music_service_tracks_attrs.map do |track_attrs|
          music_service_track_class.new(track_attrs)
        end
        music_service_album_attrs.merge!({
          total_tracks: music_service_tracks_attrs.size,
          "#{music_service_track_table_name}": music_service_tracks,
        })

        ActiveRecord::Base.transaction do
          # アルバム生成
          album = Album.find_by_isrc_or_create(
            music_service_album_attrs.slice(:release_date, :total_tracks),
            music_service_tracks_attrs.map {|track_attrs|
              track_attrs.slice(:isrc)
            },
          )

          # 統合前のアルバムを除外
          # TODO: 統合前のアルバムに複数音楽サービスが関連している可能性が考慮が漏れてる
          music_service_albums.map do |music_service_album|
            music_service_album.album.ignore!
          end

          # 統合アルバム作成
          music_service_album_attrs.merge!({ album: album })
          record = self.new(music_service_album_attrs)
          record.save!

          # 統合前アルバムに統合アルバムのIDを設定
          music_service_albums.map do |music_service_album|
            music_service_album.compacted_id = record.id
            music_service_album.save!
          end

          record
        end
      end

      # 複数アルバムへ戻す
      # 戻す場合のみ単一アルバムを消去する
      def uncompact(id)
        raise StandardError, "TTIDが違う" unless TTID.to_hash(id)[:table_id] == self.table_id

        music_service_album = find(id)

        ActiveRecord::Base.transaction do
          before_compact_music_service_albums = where(compacted_id: music_service_album.id)

          unless before_compact_music_service_albums.present?
            raise StandardError, "統合前の複数アルバムが存在しない！！"
          end

          # 音楽サービスアルバムを削除する前にアルバム保持
          album = music_service_album.album
          music_service_album.destroy!

          # アルバムに音楽サービスが存在しない場合のみ削除する
          if album.service.nil?
            album.destroy!
          end

          before_compact_music_service_albums.each do |before_compact_music_service_album|
            before_compact_music_service_album.compacted_id = nil
            before_compact_music_service_album.save!
            before_compact_music_service_album.album.pending!
          end

          before_compact_music_service_albums
        end
      end
    end
  end
end
