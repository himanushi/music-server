class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  before_action :set_current_info
  after_action :refresh_token

  attr_reader :current_info

  class Forbidden < ActionController::ActionControllerError; end
  rescue_from ApplicationController::Forbidden, with: :rescue403

  def refresh_token
    current_info[:session].refresh_token
    current_info[:session].save!

    cookie_info = {
      value: "Bearer #{current_info[:session].digit_token}",
      max_age: Session::EXPIRE_DAYS.to_i,
      http_only: true,
      same_site: :strict,
    }

    # デバッグ用
    if Rails.env.development?
      response.set_cookie(:username, {
        value: current_info[:session].user.username,
        http_only: true,
        same_site: :strict,
      })
      response.set_cookie(:name, {
        value: current_info[:session].user.name,
        http_only: true,
        same_site: :strict,
      })
    end

    if Rails.env.production?
      cookie_info.merge!({ secure: true })
    end

    response.set_cookie(:Authorization, cookie_info)
  end

  def set_current_info
    @current_info ||= begin
      token = (request.cookies["Authorization"] || "").gsub(/\ABearer /, "")

      if token.present?
        # TODO: 期限切れとかのエラーハンドリング
        session = Session.find_by_digit_token!(token)
        { user: session.user, session: session }
      else
        user = User.create_user_and_session!
        { user: user, session: user.sessions.first }
      end
    end
  # rescue
  #   # TODO: cookie リセット
  #   raise Forbidden
  end

  private
    def rescue403(e)
      render file: "#{Rails.root}/public/403.html", status: 403
    end
end
