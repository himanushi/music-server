require 'test_helper'

class AppleMusicAlbumTest < ActiveSupport::TestCase
  # Apple Music API から提供される JSON
  def data
    {
      id: "album001",
      attributes: {
        name: "album name",
        recordLabel: "label",
        copyright: "copyright",
        playParams: true,
        artwork: { url: "https://artwork", width: 100, height: 100 },
        releaseDate: "2000-01-01",
        trackCount: 1,
      },
      relationships: {
        artists: { data: [{ id: "artist001" }] },
        tracks: {
          data: [
            {
              id: "track001",
              type: "songs",
              attributes: {
                isrc: "A",
                artistName: "田中",
                name: "name1",
                discNumber: 1,
                trackNumber: 1,
                hasLyrics: false,
                playParams: true,
                durationInMillis: 1000,
                previews: [url: "https://preview"]
              }
            }
          ]
        }
      }
    }.deep_stringify_keys
  end

  def test_ok_mapping
    artist = Artist.create!(name: "田中")
    apple_music_artist = AppleMusicArtist.create!(name: "田中", artist: artist, apple_music_id: "artist001")
    apple_music_album = AppleMusicAlbum.create!(AppleMusicAlbum.mapping(data))

    # Apple Music Album
    result = apple_music_album.attributes.slice(*%w[
      apple_music_id name status playable release_date
      total_tracks record_label copyright
      artwork_url artwork_width artwork_height compacted_id
    ])
    assert_equal({
      apple_music_id: "album001",
      name: "album name",
      status: "pending",
      playable: true,
      release_date: DateTime.new(2000, 1, 1).utc,
      total_tracks: 1,
      record_label: "label",
      copyright: "copyright",
      artwork_url: "https://artwork",
      artwork_width: 100,
      artwork_height: 100,
      compacted_id: nil
    }.deep_stringify_keys, result)

    # Album
    album_result = apple_music_album.album.attributes.slice(*%w[status release_date total_tracks])
    assert_equal({
      total_tracks: 1,
      status: "pending",
      release_date: DateTime.new(2000, 1, 1).utc,
    }.deep_stringify_keys, album_result)

    # Apple Music Tracks
    apple_music_track_result = apple_music_album.apple_music_tracks[0].attributes.slice(*%w[
      apple_music_id apple_music_album_id isrc name disc_number track_number
      status playable has_lyrics duration_ms preview_url
    ])
    assert_equal 1, apple_music_album.apple_music_tracks.size
    assert_equal({
      apple_music_id: "track001",
      apple_music_album_id: apple_music_album.id,
      isrc: "A",
      name: "name1",
      disc_number: 1,
      track_number: 1,
      status: "pending",
      playable: true,
      has_lyrics: false,
      duration_ms: 1000,
      preview_url: "https://preview",
    }.deep_stringify_keys, apple_music_track_result)

    # Tracks
    track_result = apple_music_album.apple_music_tracks[0].track.attributes.slice(*%w[isrc status])
    assert_equal({
      isrc: "A",
      status: "pending",
    }.deep_stringify_keys, track_result)

    # Artist
    assert_equal 1, apple_music_album.album.artists.size
    artist_result = apple_music_album.album.artists[0].attributes.slice(*%w[name])
    assert_equal({ name: "田中" }.deep_stringify_keys, artist_result)

    # Apple Music Artist
    assert_equal 1, apple_music_album.album.artists[0].apple_music_artists.size
    apple_music_artist_result = apple_music_album.album.artists[0].apple_music_artists[0].attributes.slice(*%w[name status apple_music_id])
    assert_equal({ name: "田中", status: "pending", apple_music_id: "artist001" }.deep_stringify_keys, apple_music_artist_result)
  end

  def test_ok_create_by_apple_music_id
    artist = Artist.create!(name: "田中")
    apple_music_artist = AppleMusicArtist.create!(name: "田中", artist: artist, apple_music_id: "artist001")
    AppleMusic::Client.stub([path: "/albums/album001", body: { "data" => [data] }])
    apple_music_album = AppleMusicAlbum.create_by_apple_music_id("album001")

    # Apple Music Album
    result = apple_music_album.attributes.slice(*%w[
      apple_music_id name status playable release_date
      total_tracks record_label copyright
      artwork_url artwork_width artwork_height compacted_id
    ])
    assert_equal({
      apple_music_id: "album001",
      name: "album name",
      status: "pending",
      playable: true,
      release_date: DateTime.new(2000, 1, 1).utc,
      total_tracks: 1,
      record_label: "label",
      copyright: "copyright",
      artwork_url: "https://artwork",
      artwork_width: 100,
      artwork_height: 100,
      compacted_id: nil
    }.deep_stringify_keys, result)

    # Album
    album_result = apple_music_album.album.attributes.slice(*%w[status release_date total_tracks])
    assert_equal({
      total_tracks: 1,
      status: "pending",
      release_date: DateTime.new(2000, 1, 1).utc,
    }.deep_stringify_keys, album_result)

    # Apple Music Tracks
    apple_music_track_result = apple_music_album.apple_music_tracks[0].attributes.slice(*%w[
      apple_music_id apple_music_album_id isrc name disc_number track_number
      status playable has_lyrics duration_ms preview_url
    ])
    assert_equal 1, apple_music_album.apple_music_tracks.size
    assert_equal({
      apple_music_id: "track001",
      apple_music_album_id: apple_music_album.id,
      isrc: "A",
      name: "name1",
      disc_number: 1,
      track_number: 1,
      status: "pending",
      playable: true,
      has_lyrics: false,
      duration_ms: 1000,
      preview_url: "https://preview",
    }.deep_stringify_keys, apple_music_track_result)

    # Tracks
    track_result = apple_music_album.apple_music_tracks[0].track.attributes.slice(*%w[isrc status])
    assert_equal({
      isrc: "A",
      status: "pending",
    }.deep_stringify_keys, track_result)

    # Artist
    assert_equal 1, apple_music_album.album.artists.size
    artist_result = apple_music_album.album.artists[0].attributes.slice(*%w[name])
    assert_equal({ name: "田中" }.deep_stringify_keys, artist_result)

    # Apple Music Artist
    assert_equal 1, apple_music_album.album.artists[0].apple_music_artists.size
    apple_music_artist_result = apple_music_album.album.artists[0].apple_music_artists[0].attributes.slice(*%w[name status apple_music_id])
    assert_equal({ name: "田中", status: "pending", apple_music_id: "artist001" }.deep_stringify_keys, apple_music_artist_result)
  end

  def test_ok_artwork_l
    assert_equal "test_640x640.jpg", apple_music_albums(:sample).artwork_l.url
    assert_equal 640, apple_music_albums(:sample).artwork_l.width
    assert_equal 640, apple_music_albums(:sample).artwork_l.height
  end

  def test_ok_artwork_m
    assert_equal "test_300x300.jpg", apple_music_albums(:sample).artwork_m.url
    assert_equal 300, apple_music_albums(:sample).artwork_m.width
    assert_equal 300, apple_music_albums(:sample).artwork_m.height
  end

  def test_ok_sync_status_apple_music_tracks
    apple_music_albums(:sample).apple_music_tracks.create!(
      name: "test", track: tracks(:A), apple_music_id: "001", isrc: "A", duration_ms: 0
    )

    assert_equal "pending",  apple_music_albums(:sample).status
    assert_equal "pending",  apple_music_albums(:sample).apple_music_tracks.first.status

    apple_music_albums(:sample).active!
    assert_equal "active",  apple_music_albums(:sample).status
    assert_equal "active",  apple_music_albums(:sample).apple_music_tracks.first.status
  end
end
