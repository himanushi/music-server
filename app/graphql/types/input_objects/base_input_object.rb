module Types
  module InputObjects
    class BaseInputObject < GraphQL::Schema::InputObject
      argument_class Types::BaseArgument
      include Types::Objects
      include Types::Scalars
      include Types::InputObjects
      include Types::Enums

      def self.default_argument_values
        arguments.map {|k, v| [k, v.default_value] }.to_h.symbolize_keys
      end
    end
  end
end
