module Types
  class MutationType < Types::Objects::BaseObject
    field :signin, mutation: Mutations::Signin
    field :update_me, mutation: Mutations::UpdateMe
    field :upsert_album, mutation: Mutations::UpsertAlbum
  end
end
