# frozen_string_literal: true

class ApplicationController < ::ActionController::Base
  before_action :current_info
  after_action :refresh_token

  def current_info
    @current_info ||=
      if token.present?
        begin
          session = ::Session.find_by_digit_token!(token)
          user = session.user
          { user: user, session: session, cookie: request.cookies }
        rescue ::StandardError
          create_current_info
        end
      else
        create_current_info
      end
  end

  def refresh_token
    # web 以外は GraphQL のデータと一緒に token を返す
    return unless web?

    auth_setting = {
      value: "Bearer #{current_info[:session]&.digit_token}",
      max_age: ::Session::EXPIRE_DAYS.in_seconds,
      http_only: true,
      same_site: :lax,
      path: '/'
    }

    auth_setting.merge!({ secure: true }) if ::Rails.env.production?

    response.set_cookie('Authorization', auth_setting)
  end

  def platform
    request.env['HTTP_ORIGIN'] == 'capacitor://localhost' ? 'ios' : 'web'
  end

  def web?
    platform == 'web'
  end

  private

  def token
    # @type var authorization: ::String?
    authorization = web? ? request.cookies['Authorization'] : request.headers['Authorization']
    (authorization || '').gsub(/\ABearer /, '')
  end

  def create_current_info
    user = ::User.create_user_and_session!
    session = user.sessions.first

    { user: user, session: session, cookie: request.cookies }
  end
end
