class Mutations::Signup < Mutations::BaseMutation
  description "サインアップ"

  argument :name, String, required: true
  argument :username, String, required: true
  argument :new_password, String, required: true
  argument :new_password_confirmation, String, required: true

  field :current_user, Types::Objects::CurrentUserType, null: true

  class RegisteredError < StandardError; end

  def use_recaptcha?; true end

  def mutate(name:, username:, new_password:, new_password_confirmation:)

    # 登録済みは正常終了しておく
    if context[:current_info][:user].registered
      return {
        current_user: context[:current_info][:user],
      }
    end

    unless new_password.present?
      raise GraphQL::ExecutionError.new(
        "パスワードは必須です",
        extensions: { code: "INVALID_VALUE", path: "new_password" }
      )
    end

    attrs = {
      name: name,
      username: username,
      password: new_password,
      password_confirmation: new_password_confirmation,
      registered: true,
      role: Role.login_role
    }

    # 設定したら全てのセッションを削除し、最新セッション作成
    ActiveRecord::Base.transaction do
      context[:current_info][:user].update!(attrs)
      context[:current_info][:user].sessions.delete_all
      context[:current_info][:session] = context[:current_info][:user].sessions.create!
    end

    {
      current_user: context[:current_info][:user],
    }
  end
end
