# frozen_string_literal: true

module Queries
  class AllActionsQuery < ::Queries::BaseQuery
    description 'アクション一覧取得'

    type [::Types::Enums::ActionEnum], null: false

    def query = ::AllowedAction.all_actions
  end
end
