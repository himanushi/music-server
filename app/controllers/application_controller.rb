class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :set_current_user
  after_action :refresh_token

  attr_reader :current_user

  def refresh_token
    cookie_info = {
      value: "Bearer #{current_user.digit_token}",
      max_age: 7.days.to_i,
      http_only: true,
      same_site: :strict,
    }

    if Rails.env.production?
      cookie_info.merge!({ secure: true })
    end

    response.set_cookie(:Authorization, cookie_info)
  end

  def set_current_user
    @current_user ||= begin
      token = (request.cookies["Authorization"] || "").gsub(/\ABearer /, "")

      if token.present?
        User.find_by_digit_token!(token)
      else
        User.create!
      end
    end
  end
end
