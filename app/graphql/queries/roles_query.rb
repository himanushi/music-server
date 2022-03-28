# frozen_string_literal: true

module Queries
  class RolesQuery < ::Queries::BaseQuery
    description 'ロール一覧取得'

    type [::Types::Objects::RoleObject], null: false

    def query = ::Role.all
  end
end
