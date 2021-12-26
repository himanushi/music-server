# frozen_string_literal: true

class Role < ::ApplicationRecord
  def table_id() = 'rol'

  has_many :users
  has_many :allowed_actions, dependent: :destroy

  class << self
    def admin() = find_by!(name: 'admin')

    def login() = find_by!(name: 'login')

    def default() = find_by!(name: 'default')
  end
end
