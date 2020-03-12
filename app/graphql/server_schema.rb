class ServerSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # N+1対策
  use GraphQL::Batch
end
