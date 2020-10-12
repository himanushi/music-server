module Types
  module Objects
    class PublicInformationType < Types::Objects::BaseObject
      description '公開情報'

      field :id, TTID, null: false, description: "ID"
      field :public_type, String, null: false, description: "公開タイプ"
    end
  end
end
