class Types::Scalars::PositiveNumber < Types::Scalars::BaseScalar
  description "正の整数"

  def self.coerce_input(input_value, context)
    if input_value.positive?
      input_value
    else
      raise GraphQL::CoercionError, "#{input_value.inspect} is not a valid positive integer"
    end
  end

  def self.coerce_result(ruby_value, context)
    ruby_value
  end
end
