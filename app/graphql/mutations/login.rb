class Mutations::Login < Mutations::BaseMutation
  description "ログイン"

  argument :username, String, required: true
  argument :current_password, String, required: true

  field :current_user, Types::Objects::CurrentUserType, null: true

  def use_recaptcha?; true end

  def mutate(username:, current_password:)
    user = User.find_by(username: username)

    unless user&.authenticate(current_password)
      raise GraphQL::ExecutionError.new(
        "ユーザーIDまたはパスワードに誤りがあります" ,
        extensions: { code: "FAILED_AUTHENTICATION" }
      )
    end

    # cookie 更新
    # 複数デバイスを許可しておく
    context[:current_info][:user] = user
    context[:current_info][:session] = user.sessions.create!

    {
      current_user: user,
    }
  end
end
