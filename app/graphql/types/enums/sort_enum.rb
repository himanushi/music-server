module Types
  module Enums
    class SortEnum < GraphQL::Schema::Enum
      value :asc,  value: :asc, description: "昇順"
      value :desc, value: :desc, description: "降順"
    end
  end
end
