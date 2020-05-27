require 'test_helper'

class AllowedActionTest < ActiveSupport::TestCase
  def test_ok_validates_name_inclusion
    action = AllowedAction.new(name: AllowedAction::ALL_ACTIONS.first, role: Role.new(name: "test"))

    assert action.save
  end

  def test_ng_validates_name_inclusion
    action = AllowedAction.new(name: "test", role: Role.new(name: "test"))

    assert_not action.save
  end
end
