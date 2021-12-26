# frozen_string_literal: true

module Mutations
  class Logout < ::Mutations::BaseMutation
    description 'ログアウト'

    field :current_user, ::Types::Objects::CurrentUserObject, null: true

    def mutate
      user = ::User.create_user_and_session!
      context[:current_info][:user]    = user
      context[:current_info][:session] = user.sessions.first

      {
        current_user: user
      }
    end
  end
end
