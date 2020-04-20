module Enums
  extend ActiveSupport::Concern

  class_methods do
    def enums(enum_name)
      defined_enums[enum_name.to_s].keys.map(&:to_sym)
    end
  end
end
