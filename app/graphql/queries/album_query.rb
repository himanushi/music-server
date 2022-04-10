# frozen_string_literal: true

module Queries
  class AlbumQuery < ::Queries::BaseQuery
    description 'アルバム情報取得'

    type ::Types::Objects::AlbumObject, null: true

    argument :id, ::String, required: true, description: 'ID'

    def query(id:)
      album = ::Album.find_by(id: id)
      return unless (apple_music_album = album&.apple_music_album)

      ::Album.includes(tracks: :apple_music_tracks)
             .where('apple_music_tracks.apple_music_album_id = :id', { id: apple_music_album.id })
             .order(
               'apple_music_tracks.disc_number': :asc,
               'apple_music_tracks.track_number': :asc
             ).find_by(id: id)
    end
  end
end
