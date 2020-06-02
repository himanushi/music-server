require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  def test_ok_find_by_isrc_or_create
    tracks = %w[A B C D].map {|isrc| Track.create!(isrc: isrc) }
    album = Album.create!(release_date: "2000-01-10", total_tracks: tracks.size, tracks: tracks)

    # 発売日が変更されないこと
    result = Album.find_by_isrc_or_create(
      { release_date: "2000-01-09", total_tracks: 4 },
      [{ isrc: "A" }, { isrc: "B" }, { isrc: "C" }, { isrc: "D" }]
    )
    assert_equal album, result
    assert_equal DateTime.new(2000, 1, 10).utc, result.release_date

    # 発売日が変更されること
    result = Album.find_by_isrc_or_create(
      { release_date: "2000-01-11", total_tracks: 4 },
      [{ isrc: "A" }, { isrc: "B" }, { isrc: "C" }, { isrc: "D" }]
    )
    assert_equal album, result
    assert_equal DateTime.new(2000, 1, 11).utc, result.release_date

    # 新しく作成されていること
    result = Album.find_by_isrc_or_create(
      { release_date: "2000-01-15", total_tracks: 3 },
      [{ isrc: "A" }, { isrc: "B" }, { isrc: "C" }]
    )
    assert_not_equal album, result
    assert_equal DateTime.new(2000, 1, 15).utc, result.release_date
    assert_equal %w[A B C], result.tracks.map(&:isrc)
  end

  def test_ng_find_by_isrc_or_create
    tracks = %w[A B C D].map {|isrc| Track.create!(isrc: isrc) }
    album = Album.create!(release_date: "2000-01-10", total_tracks: tracks.size, tracks: tracks)

    err = assert_raises(StandardError) do
      Album.find_by_isrc_or_create(
        { release_date: "2000-01-15", total_tracks: 2 },
        [{ isrc: "A" }, { isrc: "B" }, { isrc: "C" }]
      )
    end
    assert_equal "アルバムのトラック数が実トラック数と相違がある", err.message

    err = assert_raises(StandardError) do
      Album.find_by_isrc_or_create(
        { release_date: "2000-01-15", total_tracks: 4 },
        [{ isrc: "A" }, { isrc: "B" }, { isrc: "C" }]
      )
    end
    assert_equal "アルバムのトラック数が実トラック数と相違がある", err.message
  end

  def test_ok_service
    album = Album.new(release_date: "2000-01-10", total_tracks: 0)
    album.apple_music_and_itunes_album = apple_music_albums(:sample)
    album.spotify_album = spotify_albums(:sample)
    album.save!

    assert_equal apple_music_albums(:sample), album.service
  end

  def test_ok_services
    album = Album.new(release_date: "2000-01-10", total_tracks: 0)
    album.apple_music_and_itunes_album = apple_music_albums(:sample)
    album.spotify_album = spotify_albums(:sample)
    album.save!

    assert_equal [apple_music_albums(:sample), spotify_albums(:sample)], album.services
  end

  def test_ok_apple_music_album
    album = Album.create!(release_date: "2000-01-10", total_tracks: 0)
    service = apple_music_albums(:sample)
    service.album = album

    service.playable = true
    service.save!

    assert_equal service, album.apple_music_album
    assert_nil album.itunes_album
  end

  def test_ok_itunes_album
    album = Album.create!(release_date: "2000-01-10", total_tracks: 0)
    service = apple_music_albums(:sample)
    service.album = album

    service.playable = false
    service.save!

    assert_nil album.apple_music_album
    assert_equal service, album.itunes_album
  end

  def test_ok_validate_exists_services
    album = Album.create!(release_date: "2000-01-10", total_tracks: 0)

    assert_nothing_raised { album.destroy }
  end

  def test_ng_validate_exists_services
    album = Album.create!(release_date: "2000-01-10", total_tracks: 0)
    service = apple_music_albums(:sample)
    service.album = album
    service.save!

    err = assert_raises(StandardError) { album.destroy }
    assert_equal "音楽サービスが一つでも存在する場合は削除できませんよ！確認してください", err.message
  end

  def test_ok_create_all_service_albums
    album = Album.create!(release_date: "2000-01-10", total_tracks: 0)

    assert_equal [], album.create_all_service_albums
  end
  # TODO: create_all_service_albums をもっと
end
