module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    include Types::Scalars
    include Types::InputObjects
    include Types::Enums

    def resolve(**args)
      action_name = self.class.name.demodulize.camelize(:lower)
      raise ApplicationController::Forbidden, "権限がありません" unless context[:current_info][:user].can?(action_name)
      query(**args)
    end
  end
end
