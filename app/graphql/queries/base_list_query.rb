module Queries
  class BaseListQuery < BaseQuery
    argument :offset, Integer, required: false, default_value: 0,  description: "何件から取得するか"
    argument :limit,  PositiveNumber, required: false, default_value: 30, description: "何件取得するか"
    argument :asc,    Boolean, required: false, default_value: true, description: "昇順"
  end
end
