# frozen_string_literal: true

class User < ::ApplicationRecord
  def table_id() = 'usr'

  belongs_to :role
  has_many :sessions, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }

  validates :username,
            presence: true,
            length: { maximum: 15 },
            uniqueness: { case_sensitive: true, message: 'がすでに使用されています, 別のユーザーIDに変更してください' },
            format: { with: /\A[0-9a-zA-Z_]+\z/, message: 'は半角英数字(0-9,a-z,A-Z)とアンダースコア(_)のみが使用できます' }

  has_secure_password
  validates :password,
            presence: true,
            length: { minimum: 8, maximum: 72 },
            format: {
              with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]+\z/,
              message: 'は半角英数をそれぞれ1種類以上を含む必要があります'
            },
            # signup では必須だが updateMe で空白でも ok なため
            allow_blank: true

  class << self
    def create_user_and_session!
      password = "#{::SecureRandom.hex(6)}aA1"
      # @type var user: ::User
      user = new(
        name: '未設定',
        username: ::SecureRandom.hex(5).upcase,
        password: password,
        password_confirmation: password
      )
      user.role = ::Role.default
      user.sessions = [::Session.new]
      user.save!
      user
    end
  end

  def create_session
    session = ::Session.new
    sessions << session
    session
  end

  def can?(action_name)
    raise(::StandardError, "指定されたアクションは存在しません: #{action_name}") unless ::AllowedAction.all_actions.include?(action_name)

    role.allowed_actions.where(name: action_name).exists?
  end

  def favorite
    ::UserFavorite.new(id)
  end
end
