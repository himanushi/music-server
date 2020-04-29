class Mutations::UpdateMe < Mutations::BaseMutation
  description "カレントユーザー情報更新"

  argument :username, String, required: false
  argument :password, String, required: false
  argument :name, String, required: false

  field :current_user, Types::Objects::CurrentUserType, null: true
  field :error, String, null: true

  def mutate(**attrs)
    begin
      password = attrs.delete(:password)
      attrs[:encrypted_password] = BCrypt::Password.create(password, cost: 12)
      context[:current_info][:user].update!(attrs)

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
