module Types
  module Objects
    class CurrentUserType < Types::Objects::BaseObject
      description 'カレントユーザー'

      field :id,   TTID, null: false, description: "ID"
      field :name, String, null: false, description: "名前"
      field :username, String, null: false, description: "ユーザー名"
      field :role, RoleType, null: false, description: "ロール"
    end
  end
end
