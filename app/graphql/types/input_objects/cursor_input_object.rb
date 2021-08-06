module Types
  module InputObjects
    class CursorInputObject < BaseInputObject
      argument :offset, Integer, required: false, default_value: 0
      argument :limit,  Integer, required: false, default_value: 30
    end
  end
end
