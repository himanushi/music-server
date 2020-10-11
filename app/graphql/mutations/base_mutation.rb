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
  include Types::Unions
  include Types::Enums

  def use_recaptcha?
    false
  end

  def resolve(**args)
    action_name = self.class.name.demodulize.camelize(:lower)

    # 権限とか
    if use_recaptcha?
      token = context.dig(:current_info, :cookie, "reCAPTCHAv2Token")
      raise ApplicationController::Forbidden, "ロボットによる操作の可能性があります" unless Google::Recaptcha.valid?(token)
    end
    raise ApplicationController::Forbidden, "権限がありません" unless context[:current_info][:user].can?(action_name)

    mutate(**args)
  end
end
