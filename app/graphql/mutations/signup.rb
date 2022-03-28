# frozen_string_literal: true

module Mutations
  class Signup < ::Mutations::BaseMutation
    description 'サインアップ'

    argument :name, ::String, required: true
    argument :username, ::String, required: true
    argument :new_password, ::String, required: true
    argument :new_password_confirmation, ::String, required: true

    field :current_user, ::Types::Objects::CurrentUserObject, null: true

    def use_recaptcha? = true

    def mutate(name:, username:, new_password:, new_password_confirmation:)
      current_user = context[:current_info][:user]

      # 登録済みは正常終了
      return { current_user: current_user } if current_user.registered

      unless new_password.present?
        raise(::GraphQL::ExecutionError.new('パスワードは必須です', extensions: { code: 'INVALID_VALUE', path: 'new_password' }))
      end

      # 管理者のみロール変更なし
      role = current_user.role.name == 'admin' ? ::Role.admin : ::Role.login
      attrs = {
        name: name,
        username: username,
        password: new_password,
        password_confirmation: new_password_confirmation,
        registered: true,
        role: role
      }

      # 設定したら全てのセッションを削除しセッション作成
      ::ActiveRecord::Base.transaction do
        current_user.update!(attrs)
        current_user.sessions.delete_all
        context[:current_info][:session] = current_user.create_session
      end

      {
        current_user: current_user
      }
    end
  end
end
