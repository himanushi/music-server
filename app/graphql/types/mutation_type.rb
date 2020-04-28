module Types
  class MutationType < Types::Objects::BaseObject
    field :update_user, mutation: Mutations::UpdateUser
    field :signin, mutation: Mutations::Signin
  end
end
