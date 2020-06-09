require 'test_helper'

class AppleMusicArtistTest < ActiveSupport::TestCase
  def test_ok_mapping
    artist = Artist.create!(name: "test artist", status: :active)
    result = AppleMusicArtist.mapping({ "id" => "001", "attributes" => { "name" => "test artist" } })

    assert_equal artist.id, result[:artist_id]
    assert_equal "001", result[:apple_music_id]
    assert_equal "Test Artist", result[:name]
    assert_equal :active, result[:status]
  end
end
