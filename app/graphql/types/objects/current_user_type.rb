module Types
  module Objects
    class CurrentUserType < Types::Objects::BaseObject
      description 'カレントユーザー'

      field :id,   TTID, null: false, description: "ID"
      field :name, String, null: false, description: "名前"
      field :username, String, null: false, description: "ユーザー名"
      field :role, RoleType, null: false, description: "ロール"
      field :favorite, FavoriteType, null: false, description: "お気に入り"
      field :registered, Boolean, null: false, description: "登録済み"
      field :public_informations, [PublicInformationType], null: false, description: "公開情報"

      def name
        object.registered ? object.name : ""
      end

      def username
        object.registered ? object.username : ""
      end
    end
  end
end
