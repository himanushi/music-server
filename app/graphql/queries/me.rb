module Queries
  class Me < BaseQuery
    description "カレントユーザー情報取得"

    type Types::Objects::CurrentUserType, null: false

    def query
      context[:current_info][:user]
    end
  end
end
