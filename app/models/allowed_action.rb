class AllowedAction < ApplicationRecord
  table_id :awd

  belongs_to :role

  MUTATION_ACTIONS = Types::MutationType.fields.keys
  QUERY_ACTIONS = Types::QueryType.fields.keys
  CONSOLE_ACTIONS = %w[graphiql]
  DEFAULT_ACTIONS = QUERY_ACTIONS + ["signin"]

  ALL_ACTIONS = MUTATION_ACTIONS + QUERY_ACTIONS + CONSOLE_ACTIONS
end
