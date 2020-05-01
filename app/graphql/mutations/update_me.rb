class Mutations::UpdateMe < Mutations::BaseMutation
  description "カレントユーザー情報更新"

  argument :name, String, required: false
  argument :username, String, required: false
  argument :new_password,  String, required: false
  argument :old_password, String, required: true

  field :current_user, Types::Objects::CurrentUserType, null: true
  field :error, String, null: true
  # TODO: ロール管理API
  # TODO: ロール変更API
  def mutate(**attrs)
    begin
      old_password = attrs.delete(:old_password)

      # なりすまし対策
      if context[:current_info][:user].encrypted_password.present?
        hash_password = BCrypt::Password.new(context[:current_info][:user].encrypted_password)
        raise StandardError unless hash_password == old_password
      end

      # パスワード更新
      if (new_password = attrs.delete(:new_password)).present?
        attrs[:encrypted_password] = BCrypt::Password.create(new_password, cost: 12)
        # パスワードを変更したら全てのセッションを削除し、最新セッション作成
        context[:current_info][:user].sessions.delete_all
        context[:current_info][:session] = context[:current_info][:user].create_session!
      end

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
