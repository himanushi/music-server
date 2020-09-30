class Mutations::Login < Mutations::BaseMutation
  description "ログイン"

  argument :username, String, required: false
  argument :password, String, required: false

  field :current_user, Types::Objects::CurrentUserType, null: true
  field :error, String, null: true

  def mutate(username:, password:)
    begin
      user = User.find_by!(username: username)
      hash_password = BCrypt::Password.new(user.encrypted_password)
      raise StandardError, "ユーザー名またはパスワードが違います" unless hash_password == password

      # cookie 更新
      # 複数デバイスを許可しておく
      context[:current_info][:user] = user
      context[:current_info][:session] = user.sessions.create!

      {
        current_user: user,
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
