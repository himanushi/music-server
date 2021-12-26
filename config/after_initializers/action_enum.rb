# frozen_string_literal: true

# ::AllowedAction.all_actions の宣言後に宣言したいため
module Types
  module Enums
    class ActionEnum < ::Types::Enums::BaseEnum
      ::AllowedAction.all_actions.each do |action|
        value action, value: action
      end
    end
  end
end
