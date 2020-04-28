module Types
  module Objects
    class UserType < Types::Objects::BaseObject
      description 'ユーザー'

      field :id,   TTID, null: false, description: "ID"
      field :name, String, null: false, description: "名前"
      field :username, String, null: false, description: "ユーザー名"
    end
  end
end
