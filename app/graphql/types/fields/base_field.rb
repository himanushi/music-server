# frozen_string_literal: true

module Types
  module Fields
    class BaseField < ::GraphQL::Schema::Field
      argument_class ::Types::Arguments::BaseArgument

      def resolve_field(obj, args, ctx) = resolve(obj, args, ctx)
    end
  end
end
