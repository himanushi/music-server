module Types
  module Objects
    class RoleType < Types::Objects::BaseObject
      description 'ロール'

      field :id,   TTID, null: false, description: "ID"
      field :name, String, null: false, description: "名前"
      field :description, String, null: false, description: "説明"
      field :allowed_actions, [String], null: false, description: "出来ること一覧"

      def allowed_actions
        object.allowed_actions.map(&:name).map do |name|
          Types::MutationType.fields.merge(Types::QueryType.fields)[name].description
        end
      end
    end
  end
end
