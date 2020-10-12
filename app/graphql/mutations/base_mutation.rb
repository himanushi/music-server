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

  attr_reader :error_message
  def use_recaptcha?; false end

  def resolve(**args)
    action_name = self.class.name.demodulize.camelize(:lower)

    # 権限
    raise ApplicationController::Forbidden, "エラー : 権限がありません" unless context[:current_info][:user].can?(action_name)

    # ロボット検証
    @error_message = ""
    if use_recaptcha?
      token = context.dig(:current_info, :cookie, "reCAPTCHAv2Token")
      @error_message = "エラー : ロボット操作の可能性があります。再入力をお願いします。" unless Google::Recaptcha.valid?(token)
    end

    mutate(**args)
  end
end
