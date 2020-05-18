class Mutations::Signin < Mutations::BaseMutation
  description "サインイン"

  argument :username, String, required: false
  argument :password, String, required: false

  field :current_user, Types::Objects::CurrentUserType, null: true
  field :error, String, null: true

  def mutate(username:, password:)
    begin
      user = User.find_by!(username: username)
      hash_password = BCrypt::Password.new(user.encrypted_password)
      raise StandardError unless hash_password == password

      # cookie 更新
      context[:current_info][:user] = user
      context[:current_info][:session] = user.create_session!

      {
        current_user: user,
        error: nil,
      }
    rescue => error
      {
        current_user: nil,
        error: "ユーザー名またはパスワードが違います",
      }
    end
  end
end
