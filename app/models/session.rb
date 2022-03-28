# frozen_string_literal: true

class Session < ::ApplicationRecord
  EXPIRE_DAYS = 30.days
  public_constant :EXPIRE_DAYS

  belongs_to :user

  before_create :refresh_token

  def table_id = 'ses'

  def refresh_token
    self.token = ::SecureRandom.hex(10)
  end

  def digit_token
    ::JwtUtil.encode({ token: token })
  end

  class << self
    def find_by_digit_token!(digit_token)
      token = ::JwtUtil.decode(digit_token)['token']
      find_by!(token: token)
    end
  end
end
