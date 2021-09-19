class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  before_action :set_current_info
  after_action :refresh_token

  attr_reader :current_info

  class Forbidden < ActionController::ActionControllerError; end
  rescue_from StandardError, with: :rescue500
  rescue_from ApplicationController::Forbidden, with: :rescue403

  def set_current_info
    @current_info ||= begin
      authorization = web? ? request.cookies["Authorization"] : request.headers["Authorization"]
      token = (authorization || "").gsub(/\ABearer /, "")

      if token.present?
        begin
          session = Session.find_by_digit_token!(token)
          { user: session.user, session: session, cookie: request.cookies, set_cookies: {} }
        rescue => e
          user = User.create_user_and_session!
          { user: user, session: user.sessions.first, cookie: request.cookies, set_cookies: {} }
        end
      else
        user = User.create_user_and_session!
        { user: user, session: user.sessions.first, cookie: request.cookies, set_cookies: {} }
      end
    end
  end

  def platform
    request.env["HTTP_ORIGIN"] == "capacitor://localhost" ? "ios" : "web"
  end

  def web?
    platform == "web"
  end

  def refresh_token
    # web 以外は GraphQL のデータと一緒に token を返す
    return unless web?

    # TODO: Session model 自体に expire を持たせること
    auth_setting = {
      value: "Bearer #{current_info[:session].digit_token}",
      max_age: Session::EXPIRE_DAYS.to_i,
      http_only: true,
      same_site: :lax,
      path: "/",
    }

    if Rails.env.production?
      auth_setting.merge!({ secure: true })
    end

    auth_cookie = { Authorization: auth_setting }
    current_info[:set_cookies] = current_info[:set_cookies].merge(auth_cookie)

    current_info[:set_cookies].each do |key, value|
      response.set_cookie(key, value)
    end
  end

  private

    def rescue403(e)
      render file: "#{Rails.root}/public/403.html", status: 403
    end

    def rescue500(e)
      render file: "#{Rails.root}/public/500.html", status: 500
    end
end
