class ApplicationRecord < ActiveRecord::Base
  include TTID
  self.abstract_class = true
end
