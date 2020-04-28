class Mutations::Signin < Mutations::BaseMutation
  argument :username, String, required: false
  argument :password, String, required: false

  field :user, Types::Objects::UserType, null: true
  field :errors, String, null: true

  def resolve(username:, password:)
    begin
      user = User.find_by!(username: username)
      hash_password = BCrypt::Password.new(user.encrypted_password)
      raise StandardError unless hash_password == password

      # cookie 更新
      context[:current_info][:user] = user
      context[:current_info][:session] = user.create_session!

      {
        user: user,
        errors: nil,
      }
    rescue => error
      {
        user: nil,
        errors: "ユーザー名またはパスワードが違います",
      }
    end
  end
end
