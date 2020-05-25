module Queries
  class Roles < BaseQuery
    description "ロール一覧取得"

    type [RoleType], null: false

    def query
      ::Role.all
    end
  end
end
