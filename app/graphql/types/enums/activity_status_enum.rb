module Types
  module Enums
    class ActivityStatusEnum < GraphQL::Schema::Enum
      value "ACTIVE", value: "active"
      value "INACTIVE",  value: "inactive"
    end
  end
end
