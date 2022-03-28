# frozen_string_literal: true

module Queries
  class DefineTypes < ::Queries::BaseQuery
    description '型定義用'

    type ::GraphQL::Types::Boolean, null: false

    argument :action, ::Types::Enums::ActionEnum, required: true, description: '全てのAllowedActions'

    def query = true
  end
end
