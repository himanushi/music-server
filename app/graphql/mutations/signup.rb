class Mutations::Signup < Mutations::BaseMutation
  description "サインアップ"

  argument :name, String, required: true
  argument :username, String, required: true
  argument :new_password,  String, required: true
  argument :old_password, String, required: true

  field :current_user, Types::Objects::CurrentUserType, null: true
  field :error, String, null: true

  class RegisteredError < StandardError; end

  def mutate(**attrs)
    begin
      # 登録済みは正常終了しておく
      raise RegisteredError if context[:current_info][:user].registered?

      # パスワード検証
      old_password = attrs.delete(:old_password)
      new_password = attrs.delete(:new_password)
      raise StandardError, "エラー : パスワードが一致しません" unless old_password == new_password

      # パスワードを設定したら全てのセッションを削除し、最新セッション作成
      attrs[:encrypted_password] = BCrypt::Password.create(new_password, cost: 12)
      context[:current_info][:user].sessions.delete_all
      context[:current_info][:session] = context[:current_info][:user].sessions.create!
      context[:current_info][:user].update!(attrs)

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
