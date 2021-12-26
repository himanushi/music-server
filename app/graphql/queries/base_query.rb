# frozen_string_literal: true

module Queries
  class BaseQuery < ::GraphQL::Schema::Resolver
    def resolve(**args)
      query(**args)
    end
  end
end
