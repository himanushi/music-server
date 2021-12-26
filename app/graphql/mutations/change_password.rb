# frozen_string_literal: true

module Mutations
  class ChangePassword < ::Mutations::BaseMutation
    description 'パスワード変更'

    argument :current_password, ::String, required: true
    argument :new_password, ::String, required: true
    argument :new_password_confirmation, ::String, required: true

    field :current_user, ::Types::Objects::CurrentUserObject, null: true

    def mutate(current_password:, new_password:, new_password_confirmation:)
      unless context[:current_info][:user].authenticate(current_password)
        raise(
          ::GraphQL::ExecutionError.new(
            '現在のパスワードが違います',
            extensions: { code: 'FAILED_AUTHENTICATION', path: 'current_password' }
          )
        )
      end

      unless new_password.present?
        raise(
          ::GraphQL::ExecutionError.new(
            '新しいパスワードを設定してください',
            extensions: { code: 'FAILED_AUTHENTICATION', path: 'new_password' }
          )
        )
      end

      ::ActiveRecord::Base.transaction do
        context[:current_info][:user].update!(
          password: new_password,
          password_confirmation: new_password_confirmation
        )

        context[:current_info][:user].sessions.delete_all
        context[:current_info][:session] = context[:current_info][:user].create_session
      end

      {
        current_user: context[:current_info][:user].reload
      }
    end
  end
end
