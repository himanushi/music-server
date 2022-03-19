# frozen_string_literal: true

class GraphqlController < ::ApplicationController
  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = { current_info: current_info, platform: platform }
    result = ::ServerSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    token!(result)
    render(json: result)
  rescue ::StandardError => e
    raise(e) unless ::Rails.env.development?

    handle_error_in_development(e)
  end

  private

  def token!(result)
    # web は cookie で対応
    return if web?

    result['extensions'] = { Authorization: "Bearer #{current_info[:session]&.digit_token}" }
  end

  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when ::String
      if ambiguous_param.present?
        ensure_hash(::JSON.parse(ambiguous_param))
      else
        {}
      end
    when ::Hash, ::ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise(::ArgumentError, "Unexpected parameter: #{ambiguous_param}")
    end
  end

  def handle_error_in_development(error)
    json = { error: { message: error.message, backtrace: error.backtrace }, data: { error: error.message } }
    render(json: json, status: 500)
  end
end
