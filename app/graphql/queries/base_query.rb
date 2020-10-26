module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    include Types::Scalars
    include Types::Objects
    include Types::InputObjects
    include Types::Enums

    def resolve(**args)
      action_name = self.class.name.demodulize.camelize(:lower)
      unless context[:current_info][:user].can?(action_name)
        raise GraphQL::ExecutionError.new('エラー : 権限がありません', extensions: { status: 403 })
      end
      query(**args)
    end
  end
end
