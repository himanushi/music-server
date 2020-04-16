class ServerSchema < GraphQL::Schema
  query(Types::QueryType)

  # N+1対策
  use GraphQL::Batch
end
