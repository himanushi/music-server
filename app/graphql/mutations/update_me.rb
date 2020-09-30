class Mutations::UpdateMe < Mutations::BaseMutation
  description "カレントユーザー情報更新"

  argument :name, String, required: false

  argument :new_password,  String, required: false
  argument :old_password, String, required: false

  field :current_user, Types::Objects::CurrentUserType, null: true
  field :error, String, null: true

  def mutate(**attrs)
    begin
      ### ユーザー情報更新
      _attrs = attrs.slice(:name)

      ### パスワード変更
      old_password = attrs.delete(:old_password)
      new_password = attrs.delete(:new_password)

      # 現在のパスワードを検証
      if old_password || new_password
        raise StandardError, "エラー : 現在のパスワードを入力してください" unless old_password.present?
        raise StandardError, "エラー : 新しいパスワードを入力してください" unless new_password.present?

        hash_password = BCrypt::Password.new(context[:current_info][:user].encrypted_password)
        raise StandardError, "エラー : 現在のパスワードが違います"        unless hash_password == old_password

        attrs[:encrypted_password] = BCrypt::Password.create(new_password, cost: 12)
        # パスワードを変更したら全てのセッションを削除し、最新セッション作成
        context[:current_info][:user].sessions.delete_all
        context[:current_info][:session] = context[:current_info][:user].sessions.create!
      end

      context[:current_info][:user].update!(_attrs)

      {
        current_user: context[:current_info][:user],
        error: nil,
      }
    rescue => error
      {
        current_user: nil,
        error: error.message
      }
    end
  end
end
