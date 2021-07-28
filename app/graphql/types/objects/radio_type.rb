module Types
  module Objects
    class RadioType < Types::Objects::BaseObject
      description 'ラジオ'

      field :id,             TTID, null: false, description: "ID"
      field :name,           String, null: false, description: "名前"
      field :description,    String, null: false, description: "説明"
      field :start_datetime, GraphQL::Types::ISO8601DateTime, null: true, description: "放送開始日"
      field :track_number,   Integer, null: false, description: "トラック番号"
      field :duration_ms,    Integer, null: false, description: "再生時間"
      field :tracks,         [TrackType], null: false
      field :track,          TrackType, null: true, description: "ジャケットトラック"
      field :is_mine,        Boolean, null: true, description: "自身のラジオか判定"

      def name
        object.playlist.name
      end

      def description
        object.playlist.description
      end

      def track
        object.playlist.track
      end

      def track_number
        object.current_track_number_and_time[0]
      end

      def duration_ms
        object.current_track_number_and_time[1]
      end

      def is_mine
        object.playlist.user.id == context[:current_info][:user].id
      end
    end
  end
end
