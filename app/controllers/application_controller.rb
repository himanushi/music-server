class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  after_action :refresh_token, only: :execute

  def refresh_token
    cookie_info = {
      value: current_user.token,
      max_age: 7.days.to_i,
      http_only: true,
      secure: true,
      same_site: :strict,
    }

    response.set_cookie(:token, cookie_info)
  end

  def current_user
    @current_user ||= begin
      token = request.cookies["token"]

      if token.present?
        User.find_by_token!(token)
      else
        User.create!(name: SecureRandom.hex(3).upcase)
      end
    end
  end
end
