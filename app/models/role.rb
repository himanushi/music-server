class Role < ApplicationRecord
  table_id :role

  has_many :users
  has_many :allowed_actions

  class << self
    # TODO: 権限適当なのであとで適切にする
    def find_or_create_by_default_role
      Role.find_or_create_by(name: "default", description: "初期ロール") do |role|
        AllowedAction::ALL_ACTIONS.each do |action_name|
          role.allowed_actions.new(name: action_name)
        end
      end
    end
  end
end
