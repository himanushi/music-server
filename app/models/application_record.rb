class ApplicationRecord < ActiveRecord::Base
  include TTID
  include Enums
  self.abstract_class = true

  class << self
    def pure_associations
      reflect_on_all_associations.select do |association|
        !association.options.has_key?(:through)
      end
    end

    # 関連が増えても気づけるような実装を可能にする
    def validate_associations(_associations)
      names = pure_associations.map(&:name)
      unless (names - _associations).blank?
        raise StandardError, "#{self.name} の関連が増えたらここも変更してね"
      end
    end
  end
end
