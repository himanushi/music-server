class AllowedAction < ApplicationRecord
  table_id :alac

  belongs_to :role

  ALL_ACTIONS = Types::MutationType.fields.keys + Types::QueryType.fields.keys
end
