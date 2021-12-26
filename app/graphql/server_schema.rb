# frozen_string_literal: true

class ServerSchema < ::GraphQL::Schema
  mutation(::Mutation)
  query(::Query)
end
