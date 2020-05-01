class User < ApplicationRecord
  table_id :usr

  has_many :sessions, dependent: :destroy

  validates :name, :username, presence: true
  validates :username, uniqueness: true, format: { with: /\A[0-9a-zA-Z]+\z/, message: "半角英数字のみが使えます" }

  belongs_to :role

  class << self
    def create_user_and_session!
      user = new(
        name: "未設定",
        username: SecureRandom.hex(5).upcase,
      )
      user.role = Role.default_role
      user.create_session!
      user
    end
  end

  def create_session!
    session = sessions.new
    save!
    session
  end

  def can?(action_name)
    role.allowed_actions.where(name: action_name).exists?
  end
end
