# frozen_string_literal: true

class Mutation < ::Types::Objects::BaseObject
  field :login, mutation: ::Mutations::Login
  field :logout, mutation: ::Mutations::Logout
  field :signup, mutation: ::Mutations::Signup
  field :update_me, mutation: ::Mutations::UpdateMe
  field :change_password, mutation: ::Mutations::ChangePassword
  field :change_favorites, mutation: ::Mutations::ChangeFavorites
  field :add_album, mutation: ::Mutations::AddAlbum
  field :update_album, mutation: ::Mutations::UpdateAlbum
  field :add_artist, mutation: ::Mutations::AddArtist
  field :change_artist_status, mutation: ::Mutations::ChangeArtistStatus
  field :change_album_status, mutation: ::Mutations::ChangeAlbumStatus
  field :force_ignore_album, mutation: ::Mutations::ForceIgnoreAlbum
  field :ignore_artists, mutation: ::Mutations::IgnoreArtists
  field :ignore_albums, mutation: ::Mutations::IgnoreAlbums
  field :upsert_playlist, mutation: ::Mutations::UpsertPlaylist
  field :add_playlist_items, mutation: ::Mutations::AddPlaylistItems
  field :delete_playlist, mutation: ::Mutations::DeletePlaylist
  field :add_role, mutation: ::Mutations::AddRole
  field :update_role, mutation: ::Mutations::UpdateRole
  field :clear_cache, mutation: ::Mutations::ClearCache
end
