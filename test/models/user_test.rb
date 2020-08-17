require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_ok_validates_username_format
    role = Role.create!(name: "default")
    user = User.new(name: "test", role: role)
    user.username = "09azAZ"

    assert user.save
  end

  def test_ng_validates_username_format
    role = Role.create!(name: "default")
    user = User.new(name: "test", role: role)

    user.username = "09azAZあ"
    assert_not user.save

    user.username = nil
    assert_not user.save
  end

  def test_ok_create_user_and_session!
    role = Role.create!(name: "default")
    user = User.create_user_and_session!

    assert_equal "未設定", user.name
    assert_match /\A[A-Z0-9]{10}\z/, user.username
    assert_equal role, user.role
    assert_equal 1, user.sessions.size
  end

  def test_ok_can?
    role = Role.create!(name: "default")
    ["me", "updateMe"].each {|name| AllowedAction.create!(name: name, role: role) }
    user = User.create!(name: "test", username: "test", role: role)

    assert user.can?("me")
    assert user.can?("updateMe")
  end

  def test_ng_can?
    role = Role.create!(name: "default")
    ["me", "updateMe"].each {|name| AllowedAction.create!(name: name, role: role) }
    user = User.create!(name: "test", username: "test", role: role)

    err = assert_raises(StandardError) { user.can?("Me") }
    assert_equal "指定されたアクションは存在しません", err.message
    err = assert_raises(StandardError) { user.can?(nil) }
    assert_equal "指定されたアクションは存在しません", err.message
  end
end
