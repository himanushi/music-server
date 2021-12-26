# frozen_string_literal: true

module Mutations
  class Login < ::Mutations::BaseMutation
    description 'ログイン'

    argument :username, ::String, required: true
    argument :current_password, ::String, required: true

    field :current_user, ::Types::Objects::CurrentUserObject, null: true

    def use_recaptcha?() = true

    def mutate(username:, current_password:)
      user = ::User.find_by(username: username)

      unless user && user.authenticate(current_password)
        raise(::GraphQL::ExecutionError.new('ユーザーIDまたはパスワードに誤りがあります', extensions: { code: 'FAILED_AUTHENTICATION' }))
      end

      context[:current_info][:user] = user
      context[:current_info][:session] = user.create_session

      {
        current_user: user
      }
    end
  end
end
