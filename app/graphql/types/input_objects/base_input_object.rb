module Types
  module InputObjects
    class BaseInputObject < GraphQL::Schema::InputObject
      argument_class Types::BaseArgument
      include Types::Objects
      include Types::Scalars
      include Types::InputObjects
    end
  end
end
