module AppleMusic
  class Token
    class << self
      def create_client_token
        create(ENV['APPLE_MUSIC_CLIENT_PRIVATE_KEY'].gsub(/\\n/,"\n"), ENV['APPLE_MUSIC_CLIENT_KEY_ID'], 8)
      end

      def create_server_token
        create(ENV['APPLE_MUSIC_SERVER_PRIVATE_KEY'].gsub(/\\n/,"\n"), ENV['APPLE_MUSIC_SERVER_KEY_ID'], 3)
      end

      def create(private_key, keyId, hours)
        teamId        = ENV['APPLE_MUSIC_TEAM_ID']
        algorithm     = 'ES256'
        hours_to_live = hours
        time_now      = Time.now.to_i
        time_expired  = Time.now.to_i + hours_to_live * 3600

        headers = {
          'typ': 'JWT',
          'kid': keyId,
        }

        payload = {
          'iss': teamId,
          'exp': time_expired,
          'iat': time_now,
        }

        ecdsa_key = OpenSSL::PKey::EC.new(private_key)
        ecdsa_key.check_key

        {
          access_token: JWT.encode(payload, ecdsa_key, algorithm, header_fields = headers),
          token_type: "Bearer",
          expires_on: Time.at(time_expired),
        }
      end
    end
  end
end
