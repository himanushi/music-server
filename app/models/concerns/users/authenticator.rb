module Users
  module Authenticator
    extend ActiveSupport::Concern

    included do
      after_initialize :init_info
    end

    def init_info
      self.name = SecureRandom.hex(5).upcase
      self.username = self.name
      self.token = SecureRandom.hex(20)
    end

    def digit_token
      JwtUtil.encode({ token: token })
    end

    class_methods do
      def find_by_digit_token!(digit_token)
        token = JwtUtil.decode(digit_token)["token"]
        user = find_by!(token: token)
        user.token = SecureRandom.hex(20)
        user.save!
        user
      end
    end
  end
end
