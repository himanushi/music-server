# frozen_string_literal: true

class Query < ::Types::Objects::BaseObject
  field :me, resolver: ::Queries::MeQuery
  field :artist, resolver: ::Queries::ArtistQuery
  field :artists, resolver: ::Queries::ArtistsQuery
  field :album, resolver: ::Queries::AlbumQuery
  field :albums, resolver: ::Queries::AlbumsQuery
  field :track, resolver: ::Queries::TrackQuery
  field :tracks, resolver: ::Queries::TracksQuery
  field :playlist, resolver: ::Queries::PlaylistQuery
  field :playlists, resolver: ::Queries::PlaylistsQuery
  field :roles, resolver: ::Queries::RolesQuery
  field :all_actions, resolver: ::Queries::AllActionsQuery
  field :apple_music_token, resolver: ::Queries::AppleMusicTokenQuery
  field :define_types, resolver: ::Queries::DefineTypes
end
