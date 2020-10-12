class User < ApplicationRecord
  table_id :usr

  include Users::Favorite

  belongs_to :role
  has_many :sessions, dependent: :destroy
  has_many :public_informations, dependent: :destroy

  validates :name,
            presence: true,
            length: { maximum: 50 }

  validates :username,
            presence: true,
            length: { maximum: 15 },
            uniqueness: { case_sensitive: true, message: "がすでに使用されています, 別のユーザーIDに変更してください" },
            format: { with: /\A[0-9a-zA-Z_]+\z/, message: "は半角英数字(0-9,a-z,A-Z)とアンダースコア(_)のみが使用できます" }

  has_secure_password
  validates :password,
            presence: true,
            length: { minimum: 8 }, # かつ72文字以下
            format: {
              with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]+\z/,
              message: "は半角英数をそれぞれ1種類以上を含む必要があります"
            },
            allow_blank: true

  class << self
    def create_user_and_session!
      password = SecureRandom.hex(6) + "aA1"
      user = new(
        name: "未設定",
        username: SecureRandom.hex(5).upcase,
        password: password,
        password_confirmation: password
      )
      user.role = Role.default_role
      user.sessions = [Session.new]
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
