# frozen_string_literal: true

# パラメータはラップしない
::ActiveSupport.on_load(:action_controller) do
  wrap_parameters format: [:json]
end
