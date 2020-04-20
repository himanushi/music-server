class ApplicationRecord < ActiveRecord::Base
  include TTID
  include Enums
  self.abstract_class = true
end
