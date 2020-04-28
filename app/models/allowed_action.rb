class AllowedAction < ApplicationRecord
  table_id :alac

  belongs_to :role

  ALL_ACTIONS =
    Types::MutationType.fields.keys.map(&:underscore) +
    Types::QueryType.fields.keys.map(&:underscore)
end
