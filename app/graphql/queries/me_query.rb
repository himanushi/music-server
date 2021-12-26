# frozen_string_literal: true

module Queries
  class MeQuery < ::Queries::BaseQuery
    description 'カレントユーザー情報取得'

    type ::Types::Objects::CurrentUserObject, null: false

    def query() = context[:current_info][:user]
  end
end
