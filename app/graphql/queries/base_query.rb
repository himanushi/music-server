# frozen_string_literal: true

module Queries
  class BaseQuery < ::GraphQL::Schema::Resolver
    def resolve(**args)
      # @type var action_name: ::String
      action_name = field.name

      unless context[:current_info][:user].can?(action_name)
        raise(::GraphQL::ExecutionError.new('権限がありません', extensions: { code: 'UNAUTHORIZED' }))
      end

      query(**args)
    end
  end
end
