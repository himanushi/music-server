require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  def test_ok_admin_role
    admin_role = Role.create!(name: "admin")

    assert_equal admin_role, Role.admin_role
  end

  def test_ng_admin_role
    err = assert_raises(ActiveRecord::RecordNotFound) { Role.admin_role }

    assert_equal "Couldn't find Role", err.message
  end

  def test_ok_default_role
    default_role = Role.create!(name: "default")

    assert_equal default_role, Role.default_role
  end

  def test_ng_default_role
    err = assert_raises(ActiveRecord::RecordNotFound) { Role.default_role }

    assert_equal "Couldn't find Role", err.message
  end
end
