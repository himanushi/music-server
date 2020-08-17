class User < ApplicationRecord
  table_id :usr

  include Users::Favorite

  belongs_to :role
  has_many :sessions, dependent: :destroy
  has_many :public_informations, dependent: :destroy

  validates :name, :username, presence: true
  validates :username, uniqueness: { case_sensitive: true }, format: { with: /\A[0-9a-zA-Z]+\z/, message: "半角英数字のみが使えます" }

  class << self
    def create_user_and_session!
      user = new(
        name: "未設定",
        username: SecureRandom.hex(5).upcase,
      )
      user.role = Role.default_role
      user.sessions.new
      user.save!
      user
    end
  end

  def can?(action_name)
    unless AllowedAction::ALL_ACTIONS.include?(action_name)
      raise StandardError, "指定されたアクションは存在しません"
    end
    role.allowed_actions.where(name: action_name).exists?
  end
end
