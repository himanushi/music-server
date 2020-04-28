class ServerSchema < GraphQL::Schema
  max_depth 13

  mutation(Types::MutationType)
  query(Types::QueryType)

  # N+1対策
  use GraphQL::Batch
end
