module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    include Types::Scalars
    include Types::InputObjects
  end
end
