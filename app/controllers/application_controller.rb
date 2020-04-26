class ApplicationController < ActionController::Base
  after_action :refresh_token, only: :execute

  def refresh_token
    cookie = [
      "token=#{current_user.token}",
      "path=/",
      "expires=Tue, 19 Jan 2038 03:14:07 GMT",
    ]

    if Rails.env.production?
      cookie += [
        "Secure",
        "SameSite=strict",
        "HttpOnly",
      ]
    end

    response.set_cookie_header = cookie.join("; ")
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
