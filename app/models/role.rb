class Role < ApplicationRecord
  table_id :rol

  has_many :users
  has_many :allowed_actions, dependent: :destroy

  class << self
    def admin_role
      Role.find_by!(name: "admin")
    end

    def login_role
      Role.find_by!(name: "login")
    end

    def default_role
      Role.find_by!(name: "default")
    end
  end
end
