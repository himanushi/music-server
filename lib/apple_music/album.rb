# frozen_string_literal: true

module AppleMusic
  class Album
    class << self
      def create_full(apple_music_id, force: false)
        am_album = ::AppleMusicAlbum.find_by(apple_music_id: apple_music_id)
        return am_album unless !am_album || force

        full_album = build_json(apple_music_id)
        ::ActiveRecord::Base.transaction do
          prepare_create_artists(full_album)
        end
        ::ActiveRecord::Base.transaction do
          prepare_create_album_tracks(full_album)

          ::AppleMusicAlbum.create_by_data(full_album)
        end
      end

      def build_json(apple_music_id)
        albums_data = ::AppleMusic::Api.new.get_album(apple_music_id)
        unless (album_data = albums_data['data'].first)
          raise(::StandardError, "album data が存在しない apple_music_id(album): #{apple_music_id}")
        end

        unless album_data['relationships']['tracks']['data'].size.positive?
          raise(::StandardError, 'アルバムのトラック数が0件なので何かしらのバグがある')
        end

        tracks =
          album_data['relationships']['tracks']['data'].map do |tracks_data|
            track_data = ::AppleMusic::Api.new.get_track(tracks_data['id'])
            unless (track = track_data['data'].first)
              raise(::StandardError, "track data が存在しない apple_music_id(track): #{tracks_data['id']}")
            end

            track
          end

        unless album_data['relationships']['tracks']['data'].size == tracks.size
          raise(::StandardError, "build_json で size が合わない apple_music_id(album): #{album_data['id']}")
        end

        # @type var result: untyped
        result = albums_data
        result['data'][0]['relationships']['tracks']['data'] = tracks
        result
      end

      def prepare_create_artists(albums_data)
        return albums_data unless (album_data = albums_data['data'].first)

        # @type var artists_data: ::Array[::AppleMusic::Api::Response::simple_artist]
        artists_data = []
        album_data['relationships']['artists']['data'].each do |artist_data|
          artists_data << artist_data
        end
        album_data['relationships']['tracks']['data'].each do |tracks_data|
          tracks_data['relationships']['artists']['data'].each do |artist_data|
            artists_data << artist_data
          end
        end

        # artists
        artists_data.uniq.each do |artist_data|
          next unless (attributes = artist_data['attributes'])

          artist = ::Artist.find_or_initialize_by(name: ::Convert.to_name(attributes['name']))
          ama = ::AppleMusicArtist.find_or_initialize_by(apple_music_id: artist_data['id'])
          ama.artist = artist
          ama.name = attributes['name']
          ama.save!
        end
      end

      def prepare_create_album_tracks(albums_data)
        return albums_data unless (album_data = albums_data['data'].first)

        # album
        album = ::Album.find_or_initialize_by(upc: album_data['attributes']['upc'].upcase)
        date = ::Convert.to_time(album_data['attributes']['releaseDate'])
        album.release_date = date if album.release_date.nil? || album.release_date <= date
        album.total_tracks = album_data['attributes']['trackCount']

        # album artists
        album_data['relationships']['artists']['data'].each do |artist_data|
          next unless (attributes = artist_data['attributes'])

          artist = ::Artist.find_by(name: ::Convert.to_name(attributes['name']))
          album.artists = (album.artists.to_a + [artist]).compact.uniq
        end

        # album tracks
        album.tracks =
          album_data['relationships']['tracks']['data'].map do |tracks_data|
            track = ::Track.find_or_initialize_by(isrc: tracks_data['attributes']['isrc'])
            track.status = album.status

            # track artists
            tracks_data['relationships']['artists']['data'].each do |artist_data|
              next unless (attributes = artist_data['attributes'])

              artist = ::Artist.find_by(name: ::Convert.to_name(attributes['name']))
              track.artists = (track.artists.to_a + [artist]).compact.uniq
            end

            track
          end

        album.save!
      end
    end
  end
end
