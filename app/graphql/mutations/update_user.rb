class Mutations::UpdateUser < Mutations::BaseMutation
  argument :username, String, required: false
  argument :password, String, required: false
  argument :name, String, required: false

  field :user, Types::Objects::UserType, null: true
  field :errors, String, null: true

  def resolve(**attrs)
    begin
      password = attrs.delete(:password)
      attrs[:encrypted_password] = BCrypt::Password.create(password, cost: 12)
      context[:current_info][:user].update!(attrs)

      {
        user: context[:current_info][:user],
        errors: nil,
      }
    rescue => error
      {
        user: nil,
        errors: error.message,
      }
    end
  end
end
