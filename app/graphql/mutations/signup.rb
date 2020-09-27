class Mutations::Signup < Mutations::BaseMutation
  description "サインアップ"

  argument :name, String, required: true
  argument :username, String, required: true
  argument :new_password,  String, required: true
  argument :old_password, String, required: true

  field :current_user, Types::Objects::CurrentUserType, null: true
  field :error, String, null: true

  def mutate(**attrs)
    begin

      # パスワード検証
      old_password = attrs.delete(:old_password)
      new_password = attrs.delete(:new_password)
      raise StandardError unless old_password == new_password

      # パスワードを変更したら全てのセッションを削除し、最新セッション作成
      attrs[:encrypted_password] = BCrypt::Password.create(new_password, cost: 12)
      context[:current_info][:user].sessions.delete_all
      context[:current_info][:session] = context[:current_info][:user].sessions.create!
      context[:current_info][:user].update!(attrs)

      {
        current_user: context[:current_info][:user],
        error: nil,
      }
    rescue ActiveRecord::RecordInvalid => error
      {
        current_user: nil,
        error: "指定したユーザー名はすでに存在します",
      }
    rescue => error
      {
        current_user: nil,
        error: "古いパスワードが違います",
      }
    end
  end
end
