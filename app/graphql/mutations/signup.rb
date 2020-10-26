class Mutations::Signup < Mutations::BaseMutation
  description "サインアップ"

  argument :name, String, required: true
  argument :username, String, required: true
  argument :password, String, required: true
  argument :password_confirmation, String, required: true

  field :current_user, Types::Objects::CurrentUserType, null: true
  field :error, String, null: true

  class RegisteredError < StandardError; end

  def use_recaptcha?; true end

  def mutate(name:, username:, password:, password_confirmation:)
    begin
      # 登録済みは正常終了しておく
      raise RegisteredError if context[:current_info][:user].registered

      attrs = {
        name: name,
        username: username,
        password: password,
        password_confirmation: password_confirmation,
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
        error: nil,
      }
    rescue RegisteredError => error
      # 登録済みは正常終了しておく
      {
        current_user: context[:current_info][:user],
        error: nil,
      }
    rescue => error
      {
        current_user: nil,
        error: error.message,
      }
    end
  end
end
