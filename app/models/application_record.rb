# frozen_string_literal: true

class ApplicationRecord < ::ActiveRecord::Base
  include ::TTID::InstanceMethods

  before_create :identify

  self.abstract_class = true
end
