class Mutations::Login < Mutations::BaseMutation
  description "ログイン"

  argument :username, String, required: true
  argument :password, String, required: true

  field :current_user, Types::Objects::CurrentUserType, null: true
  field :error, String, null: true

  def use_recaptcha?; true end

  def mutate(username:, password:)
    begin
      user = User.find_by(username: username)
      raise StandardError, "エラー : ユーザーIDまたはパスワードに誤りがあります" unless user&.authenticate(password)

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
