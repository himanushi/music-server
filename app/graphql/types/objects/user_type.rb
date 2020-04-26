module Types
  module Objects
    class UserType < Types::Objects::BaseObject
      description 'ユーザー'

      field :id,   TTID, null: false, description: "ID"
      field :name, String, null: false, description: "タイトル"
    end
  end
end
