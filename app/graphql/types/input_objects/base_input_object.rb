# frozen_string_literal: true

module Types
  module InputObjects
    class BaseInputObject < ::GraphQL::Schema::InputObject
      argument_class ::Types::Arguments::BaseArgument

      class << self
        def default_argument_values
          arguments.transform_values { |v| v.default_value }
                   .symbolize_keys
        end
      end
    end
  end
end
