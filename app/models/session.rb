class Session < ApplicationRecord
  table_id :ses

  belongs_to :user

  before_create :refresh_token

  EXPIRE_DAYS = 7.days

  def refresh_token
    self.token = SecureRandom.hex(20)
  end

  def digit_token
    JwtUtil.encode({ token: token })
  end

  class << self
    def find_by_digit_token!(digit_token)
      token = JwtUtil.decode(digit_token)["token"]
      find_by!(token: token)
    end
  end
end
