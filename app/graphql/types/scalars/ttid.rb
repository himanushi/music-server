class Types::Scalars::TTID < Types::Scalars::BaseScalar
  description "Table id and hex Timestamp and hex ID"

  def self.coerce_input(input_value, context)
    if TTID::REGEXP.match?(input_value)
      input_value
    else
      raise GraphQL::CoercionError, "#{input_value.inspect} is not a ID"
    end
  end

  def self.coerce_result(ruby_value, context)
    ruby_value
  end
end
