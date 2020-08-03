module Types
  module Objects
    class CurrentUserType < Types::Objects::BaseObject
      description 'カレントユーザー'

      field :id,   TTID, null: false, description: "ID"
      field :name, String, null: false, description: "名前"
      field :username, String, null: false, description: "ユーザー名"
      field :role, RoleType, null: false, description: "ロール"
      field :favorite, FavoriteType, null: false, description: "お気に入り"
      field :initialized, Boolean, null: false, description: "初期設定済み"

      def initialized
        object.encrypted_password.present?
      end

      def name
        initialized ? object.name : ""
      end

      def username
        initialized ? object.username : ""
      end
    end
  end
end
