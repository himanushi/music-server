module Queries
  class DefineTypes < BaseQuery
    description "型定義が欲しいのでそれ用"

    type Boolean, null: false

    argument :action, Types::Enums::ActionEnum, required: true, description: "全てのAllowedActions"

    def query(args)
      true
    end
  end
end
