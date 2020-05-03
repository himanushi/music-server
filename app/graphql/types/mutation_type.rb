module Types
  class MutationType < Types::Objects::BaseObject
    field :signin, mutation: Mutations::Signin
    field :update_me, mutation: Mutations::UpdateMe
    field :change_status, mutation: Mutations::ChangeStatus
    field :upsert_artist, mutation: Mutations::UpsertArtist
    field :upsert_album, mutation: Mutations::UpsertAlbum
    field :compact_album, mutation: Mutations::CompactAlbum
    field :uncompact_album, mutation: Mutations::UncompactAlbum
    field :mix_album, mutation: Mutations::MixAlbum
    field :unmix_album, mutation: Mutations::UnmixAlbum
  end
end
