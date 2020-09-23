class Mutations::Logout < Mutations::BaseMutation
  description "ログアウト"

  field :current_user, Types::Objects::CurrentUserType, null: true
  field :error, String, null: true

  def mutate
    begin
      user = User.create_user_and_session!

      # cookie 更新
      context[:current_info][:user]    = user
      context[:current_info][:session] = user.sessions.first

      {
        current_user: user,
        error: nil,
      }
    rescue => error
      {
        current_user: nil,
        error: "ログアウトに失敗しました",
      }
    end
  end
end
