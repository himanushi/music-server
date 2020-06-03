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
        artists: { data: [] },
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
    apple_music_album = AppleMusicAlbum.create!(AppleMusicAlbum.mapping(data))
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

    album_result = apple_music_album.album.attributes.slice(*%w[status release_date total_tracks])
    assert_equal({
      total_tracks: 1,
      status: "pending",
      release_date: DateTime.new(2000, 1, 1).utc,
    }.deep_stringify_keys, album_result)

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

    track_result = apple_music_album.apple_music_tracks[0].track.attributes.slice(*%w[isrc status])
    assert_equal({
      isrc: "A",
      status: "pending",
    }.deep_stringify_keys, track_result)
  end
end
