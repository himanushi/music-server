module Users
  module Authenticator
    extend ActiveSupport::Concern

    def token
      JwtUtil.encode({ user_id: id })
    end

    class_methods do
      def find_by_token!(token)
        id = JwtUtil.decode(token)[:user_id]
        find_by!(id)
      end
    end
  end
end
