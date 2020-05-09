module Types
  module Enums
    class SortEnum < GraphQL::Schema::Enum
      value "ASC",  value: "asc", description: "昇順"
      value "DESC", value: "desc", description: "降順"
    end
  end
end
