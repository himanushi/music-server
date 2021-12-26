# frozen_string_literal: true

module Types
  module Enums
    class SortEnum < ::Types::Enums::BaseEnum
      value 'ASC',  value: 'asc', description: '昇順'
      value 'DESC', value: 'desc', description: '降順'
    end
  end
end
