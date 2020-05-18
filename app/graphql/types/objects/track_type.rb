module Types
  module Objects
    class TrackType < Types::Objects::BaseObject
      description 'トラック'

      field :id,           TTID, null: false, description: "ID"
      field :isrc,         String, null: false, description: "国際標準レコーディングコード"
      field :name,         String, null: false, description: "タイトル"
      field :status,       StatusEnum, null: false, description: "ステータス"
      field :disc_number,  PositiveNumber, null: false, description: "ディスク番号"
      field :track_number, PositiveNumber, null: false, description: "トラック番号"
      field :duration_ms,  PositiveNumber, null: false, description: "再生時間"
      field :preview_url,  String, null: true, description: "プレビューURL"
      field :popularity,   Integer, null: false, description: "人気度"
      field :artwork_m,    ArtworkType, null: false, description: "中型アートワーク"

      def name
        object.service.name
      end

      def disc_number
        object.service.disc_number
      end

      def track_number
        object.service.track_number
      end

      def duration_ms
        object.service.duration_ms
      end

      def preview_url
        object.service.preview_url
      end

      def popularity
        object.spotify_tracks.map(&:popularity).max || 0
      end

      def artwork_m
        object.service.artwork_m
      end
    end
  end
end
