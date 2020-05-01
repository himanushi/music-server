class Mutations::BaseMutation < GraphQL::Schema::RelayClassicMutation
  # Add your custom classes if you have them:
  # This is used for generating payload types
  object_class Types::Objects::BaseObject
  # This is used for return fields on the mutation's payload
  field_class Types::Fields::BaseField
  # This is used for generating the `input: { ... }` object type
  input_object_class Types::InputObjects::BaseInputObject

  include Types::Objects
  include Types::Scalars

  def resolve(**args)
    action_name = self.class.name.demodulize.camelize(:lower)
    raise ApplicationController::Forbidden, "権限がありません" unless context[:current_info][:user].can?(action_name)
    mutate(**args)
  end
end
