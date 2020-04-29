module Types
  class MutationType < Types::Objects::BaseObject
    field :update_me, mutation: Mutations::UpdateMe
    field :signin, mutation: Mutations::Signin
  end
end
