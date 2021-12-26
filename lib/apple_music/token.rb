# frozen_string_literal: true

module AppleMusic
  class Token
    class << self
      def create_client_token
        # 1週間 = 168
        create(
          ::ENV['APPLE_MUSIC_CLIENT_PRIVATE_KEY']&.gsub(/\\n/, "\n") || '',
          ::ENV['APPLE_MUSIC_CLIENT_KEY_ID'] || '',
          168
        )
      end

      def create_server_token
        create(
          ::ENV['APPLE_MUSIC_SERVER_PRIVATE_KEY']&.gsub(/\\n/, "\n") || '',
          ::ENV['APPLE_MUSIC_SERVER_KEY_ID'] || '',
          3
        )
      end

      def create(private_key, key_id, hours_to_live)
        team_id = ::ENV['APPLE_MUSIC_TEAM_ID']
        time_now = ::Time.now.to_i
        time_expired = time_now + (hours_to_live * 3600)

        payload = { iss: team_id, exp: time_expired, iat: time_now }
        ecdsa_key = ::OpenSSL::PKey::EC.new(private_key)

        {
          access_token: ::JWT.encode(payload, ecdsa_key, 'ES256', { typ: 'JWT', kid: key_id }),
          token_type: 'Bearer',
          expires_on: ::Time.at(time_expired)
        }
      end
    end
  end
end
