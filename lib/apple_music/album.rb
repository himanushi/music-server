# frozen_string_literal: true

module AppleMusic
  class Album
    class << self
      def create_full(apple_music_id, force: false)
        am_album = ::AppleMusicAlbum.find_by(apple_music_id: apple_music_id)
        return am_album unless !am_album || force

        return unless ::IgnoreContent.where(music_service_id: apple_music_id).empty?

        album_data = build_json(apple_music_id)

        ::ActiveRecord::Base.transaction do
          prepare_create_artists(album_data)
        end

        ::ActiveRecord::Base.transaction do
          prepare_create_album_tracks(album_data)
          ::AppleMusicAlbum.create_by_data(album_data)
        end
      end

      def build_json(apple_music_id)
        albums_data = ::AppleMusic::Api.new.get_album(apple_music_id)

        unless (album_data = albums_data['data'].first)
          raise(::StandardError, "album data が存在しない apple_music_id(album): #{apple_music_id}")
        end

        tracks = album_data['relationships']['tracks']['data']

        unless tracks.size.positive?
          raise(::StandardError, "アルバムのトラック数が0件なので何かしらのバグがある apple_music_id(album): #{apple_music_id}")
        end

        unless tracks.size == tracks.map { |track| track['attributes']['isrc'] }
                                    .uniq.size

          raise(::StandardError, "ISRC がアルバム内で重複している apple_music_id(album): #{apple_music_id}")
        end

        albums_data
      end

      def create_artist(name, id)
        artist = ::Artist.find_or_initialize_by(name: ::Convert.to_name(name))
        ama = ::AppleMusicArtist.find_or_initialize_by(apple_music_id: id)
        ama.artist = artist
        # AppleMusicArtist にはオリジナルの名前を格納する
        ama.name = name
        ama.save!
      end

      def prepare_create_artists(albums_data)
        return albums_data unless (album_data = albums_data['data'].first)

        # 変換前のアーティスト名の配列
        # @type var artist_names: ::Array[::String]
        artist_names = []

        album_data['relationships']['artists']['data'].each do |artist_data|
          # name が存在しない場合がある ID: 974601659
          next unless artist_data['attributes']

          artist_name = artist_data['attributes']['name']
          artist = ::Artist.find_by_name(artist_name)

          next if artist

          create_artist(artist_name, artist_data['id'])
          artist_names << artist_name
        end

        # トラックのアーティスト名がDBに無い場合はトラック情報詳細を取得する
        album_data['relationships']['tracks']['data'].each do |tracks_data|
          artist_name = tracks_data['attributes']['artistName']
          next if artist_names.index(artist_name)

          artist = ::Artist.find_by_name(artist_name)
          next if artist

          result_tracks_data = ::AppleMusic::Api.new.get_track(tracks_data['id'])
          next unless (result_track_data = result_tracks_data['data'].first)

          result_track_data['relationships']['artists']['data'].each do |artist_data|
            create_artist(artist_data['attributes']['name'], artist_data['id'])
            artist_names << artist_data['attributes']['name']
          end
        end
      end

      def prepare_create_album_tracks(albums_data)
        return albums_data unless (album_data = albums_data['data'].first)

        # album
        isrc = album_data['relationships']['tracks']['data'].map { |data| data['attributes']['isrc'] }
        album = ::Album.find_by_isrc(isrc) || ::Album.find_or_initialize_by(upc: album_data['attributes']['upc'].upcase)

        date = ::Convert.to_time(album_data['attributes']['releaseDate'])
        album.release_date = date if album.release_date.nil? || album.release_date <= date
        album.total_tracks =
          album_data['relationships']['tracks']['data'].size || album_data['attributes']['trackCount']
        album.upc = album_data['attributes']['upc'].upcase

        # album artists
        album_data['relationships']['artists']['data'].each do |artist_data|
          # name が存在しない場合がある ID: 974601659
          next unless artist_data['attributes']

          artist = ::Artist.find_by_name(artist_data['attributes']['name'])
          album.artists = (album.artists.to_a + [artist]).compact.uniq
        end

        # album tracks
        album.tracks =
          album_data['relationships']['tracks']['data'].map do |tracks_data|
            track = ::Track.find_or_initialize_by(isrc: tracks_data['attributes']['isrc'])
            track.status = album.status

            # track artists
            artist = ::Artist.find_by_name(tracks_data['attributes']['artistName'])
            track.artists = (track.artists.to_a + [artist]).compact.uniq
            track
          end

        album.save!
      end
    end
  end
end
