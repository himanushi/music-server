# frozen_string_literal: true

module Types
  module Enums
    class FavoriteTypeEnum < ::Types::Enums::BaseEnum
      value 'Artist'
      value 'Album'
      value 'Track'
      value 'Playlist'
      value 'LibraryArtist'
      value 'LibraryAlbum'
      value 'LibraryTrack'
      value 'LibraryPlaylist'
    end
  end
end
