module Types
  class MutationType < Types::Objects::BaseObject
    field :signin, mutation: Mutations::Signin
    field :update_me, mutation: Mutations::UpdateMe
    field :change_status, mutation: Mutations::ChangeStatus
    field :upsert_artist, mutation: Mutations::UpsertArtist
    field :mix_artist, mutation: Mutations::MixArtist
    field :ignore_artist, mutation: Mutations::IgnoreArtist
    field :upsert_active_artists_has_albums, mutation: Mutations::UpsertActiveArtistsHasAlbums
    field :upsert_album, mutation: Mutations::UpsertAlbum
    field :compact_album, mutation: Mutations::CompactAlbum
    field :ignore_album, mutation: Mutations::IgnoreAlbum
    field :uncompact_album, mutation: Mutations::UncompactAlbum
    field :mix_album, mutation: Mutations::MixAlbum
    field :unmix_album, mutation: Mutations::UnmixAlbum
    field :upsert_role, mutation: Mutations::UpsertRole
    field :clear_cache, mutation: Mutations::ClearCache
  end
end
