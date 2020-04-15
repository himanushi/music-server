module Types
  module Objects
    class BaseObject < GraphQL::Schema::Object
      include Types::Objects
      include Types::Scalars
    end
  end
end
