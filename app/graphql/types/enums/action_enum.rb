module Types
  module Enums
    class ActionEnum < GraphQL::Schema::Enum
      AllowedAction::ALL_ACTIONS.each do |action|
        value action, value: action
      end
    end
  end
end
