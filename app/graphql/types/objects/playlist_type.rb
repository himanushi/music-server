module Types
  module Objects
    class PlaylistType < BaseObject
      description 'プレイリスト'

      field :id,          TTID, null: false, description: "ID"
      field :name,        String, null: false, description: "タイトル"
      field :description, String, null: false, description: "説明"
      field :public_type, PlaylistPublicTypeEnum, null: false, description: "公開種別"
      field :is_mine,     Boolean, null: true, description: "自身のプレイリストか判定"
      field :author,      UserType, null: true, description: "作者"
      field :track,       TrackType, null: true, description: "ジャケットトラック"
      field :updated_at,  GraphQL::Types::ISO8601DateTime, null: false, description: "更新日"
      field :created_at,  GraphQL::Types::ISO8601DateTime, null: false, description: "作成日"
      field :items,       [PlaylistItemType], null: false, description: "曲一覧"

      def is_mine
        object.user.id == context[:current_info][:user].id
      end

      def author
        # 冗長だが書いておく
        if !object.public_type_anonymous_open? || object.user.id == context[:current_info][:user].id
          object.user
        else
          nil
        end
      end

      def items
        object.playlist_items.include_tracks.order(:track_number)
      end
    end
  end
end
