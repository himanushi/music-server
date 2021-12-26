# frozen_string_literal: true

module Types
  module InputObjects
    class CursorInputObject < ::Types::InputObjects::BaseInputObject
      argument :offset, ::Integer, required: false, default_value: 0
      argument :limit,  ::Integer, required: false, default_value: 50
    end
  end
end
