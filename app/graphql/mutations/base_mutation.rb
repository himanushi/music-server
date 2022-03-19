# frozen_string_literal: true

module Mutations
  class BaseMutation < ::GraphQL::Schema::RelayClassicMutation
    # Add your custom classes if you have them:
    # This is used for generating payload types
    object_class ::Types::Objects::BaseObject
    # This is used for return fields on the mutation's payload
    field_class ::Types::Fields::BaseField
    # This is used for generating the `input: { ... }` object type
    input_object_class ::Types::InputObjects::BaseInputObject

    def use_recaptcha?() = false

    def resolve(**args)
      # @type var action_name: ::String
      action_name = field.name

      unless context[:current_info][:user].can?(action_name)
        raise(::GraphQL::ExecutionError.new('権限がありません', extensions: { code: 'UNAUTHORIZED' }))
      end

      # # ロボット検証
      # if ::Rails.env.production? && use_recaptcha?
      #   token = context.dig(:current_info, :cookie, 'reCAPTCHAv2Token')
      #   unless ::Ggl::Recaptcha.valid?(token)
      #     raise(
      #       ::GraphQL::ExecutionError.new(
      #         'ロボット操作の可能性があります。再入力をお願いします。',
      #         extensions: { code: 'FAILED_RECAPTCHA', path: 'recaptcha' }
      #       )
      #     )
      #   end
      # end

      begin
        mutate(**args)
      rescue ::GraphQL::ExecutionError => e
        raise(e)
      rescue ::StandardError => e
        raise(::GraphQL::ExecutionError.new(e.message, extensions: { code: 'SYSTEM_ERROR' }))
      end
    end
  end
end
