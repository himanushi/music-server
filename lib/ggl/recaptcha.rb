# frozen_string_literal: true

module Ggl
  class Recaptcha
    class << self
      def valid?(token)
        !!request(token)['success']
      end

      def request(token)
        response = ::Faraday.post(
          'https://www.google.com/recaptcha/api/siteverify',
          {
            secret: ::ENV['GOOGLE_RECAPTCHA_V2_SECRET_KEY'],
            response: token
          }
        )

        json = ::JSON.parse(response.body)
        puts(json) unless json['success']
        json
      end
    end
  end
end
