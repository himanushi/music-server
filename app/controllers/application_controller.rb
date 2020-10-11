class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  before_action :set_current_info
  after_action :refresh_token

  attr_reader :current_info

  class Forbidden < ActionController::ActionControllerError; end
  rescue_from ApplicationController::Forbidden, with: :rescue403

  def set_current_info
    @current_info ||= begin
      token = (request.cookies["Authorization"] || "").gsub(/\ABearer /, "")

      if token.present?
        begin
          session = Session.find_by_digit_token!(token)
          { user: session.user, session: session, cookie: request.cookies }
        rescue => e
          user = User.create_user_and_session!
          { user: user, session: user.sessions.first, cookie: request.cookies }
        end
      else
        user = User.create_user_and_session!
        { user: user, session: user.sessions.first, cookie: request.cookies }
      end
    end
  end

  def refresh_token
    # TODO: Session model 自体に expire を持たせること
    cookie_info = {
      value: "Bearer #{current_info[:session].digit_token}",
      max_age: Session::EXPIRE_DAYS.to_i,
      http_only: true,
      same_site: :lax,
      path: "/",
    }

    if Rails.env.production?
      cookie_info.merge!({ secure: true })
    end

    response.set_cookie(:Authorization, cookie_info)
  end

  private
    def rescue403(e)
      render file: "#{Rails.root}/public/403.html", status: 403
    end
end
