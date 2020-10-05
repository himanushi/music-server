require 'test_helper'

class SessionTest < ActiveSupport::TestCase
  def user
    User.create!(name: "test", username: "test", role: Role.create!(name: "admin"), password: "1Aaaaaaa", password_confirmation: "1Aaaaaaa")
  end

  def test_ok_before_create_refresh_token
    session = Session.create!(user: user)

    assert_match /[0-9a-f]{40}/, session.token
  end

  def test_ok_digit_token
    digit_token   = Session.create!(user: user).digit_token
    decoded_token = JwtUtil.decode(digit_token)

    assert_match /[0-9a-f]{40}/, decoded_token["token"]
  end

  def test_ok_find_by_digit_token!
    digit_token = Session.create!(user: user).digit_token

    assert_nothing_raised { Session.find_by_digit_token!(digit_token) }
  end

  def test_ng_find_by_digit_token!
    digit_token = JwtUtil.encode({ token: "a" * 40 })

    assert_raises(ActiveRecord::RecordNotFound) { Session.find_by_digit_token!(digit_token) }
  end
end
