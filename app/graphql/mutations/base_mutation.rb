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

  def use_recaptcha?; false end

  def resolve(**args)
    action_name = self.class.name.demodulize.camelize(:lower)

    # 権限
    unless context[:current_info][:user].can?(action_name)
      raise GraphQL::ExecutionError.new("権限がありません", extensions: { code: "UNAUTHORIZED" })
    end

    # ロボット検証
    if use_recaptcha?
      token = context.dig(:current_info, :cookie, "reCAPTCHAv2Token")
      unless Ggl::Recaptcha.valid?(token)
        raise GraphQL::ExecutionError.new(
          'ロボット操作の可能性があります。再入力をお願いします。',
          extensions: { code: "FAILED_RECAPTCHA", path: "recaptcha" }
        )
      end
    end

    begin
      mutate(**args)
    rescue GraphQL::ExecutionError => error
      raise error
    rescue => error
      raise GraphQL::ExecutionError.new(error.message, extensions: { code: "SYSTEM_ERROR" })
    end
  end
end
