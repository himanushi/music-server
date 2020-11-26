module Types
  class MutationType < Types::Objects::BaseObject
    field :signup,             mutation: Mutations::Signup
    field :login,              mutation: Mutations::Login
    field :logout,             mutation: Mutations::Logout
    field :update_me,          mutation: Mutations::UpdateMe
    field :change_status,      mutation: Mutations::ChangeStatus
    field :upsert_playlist,    mutation: Mutations::UpsertPlaylist
    field :add_playlist_items, mutation: Mutations::AddPlaylistItems
    field :upsert_artist,      mutation: Mutations::UpsertArtist
    field :mix_artist,         mutation: Mutations::MixArtist
    field :ignore_artists,     mutation: Mutations::IgnoreArtists
    field :upsert_album,       mutation: Mutations::UpsertAlbum
    field :compact_album,      mutation: Mutations::CompactAlbum
    field :ignore_albums,      mutation: Mutations::IgnoreAlbums
    field :force_ignore_album, mutation: Mutations::ForceIgnoreAlbum
    field :uncompact_album,    mutation: Mutations::UncompactAlbum
    field :mix_album,          mutation: Mutations::MixAlbum
    field :unmix_album,        mutation: Mutations::UnmixAlbum
    field :upsert_role,        mutation: Mutations::UpsertRole
    field :change_favorites,   mutation: Mutations::ChangeFavorites
    field :generate_sitemaps,  mutation: Mutations::GenerateSitemaps
    field :clear_cache,        mutation: Mutations::ClearCache
  end
end
