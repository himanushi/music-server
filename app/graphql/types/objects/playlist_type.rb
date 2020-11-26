module Types
  module Objects
    class PlaylistType < BaseObject
      description 'プレイリスト'

      field :id,          TTID, null: false, description: "ID"
      field :name,        String, null: false, description: "タイトル"
      field :description, String, null: false, description: "説明"
      field :public_type, String, null: false, description: "公開種別"
      field :user,        UserType, null: false, description: "作者"
      field :track,       TrackType, null: false, description: "ジャケットトラック"
      field :updated_at,  GraphQL::Types::ISO8601DateTime, null: false, description: "更新日"
      field :created_at,  GraphQL::Types::ISO8601DateTime, null: false, description: "作成日"
      field :items,       [PlaylistItemType], null: false, description: "曲一覧"

      def items
        object.playlist_items.order(:track_number)
      end
    end
  end
end
