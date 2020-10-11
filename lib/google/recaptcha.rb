module Google
  class Recaptcha
    def self.valid?(token, ip = nil)
      !!request(token, ip)["success"]
    end

    def self.request(token, ip = nil)
      ip_option = ip.present? ? { remoteip: ip } : {}

      response = Faraday.post("https://www.google.com/recaptcha/api/siteverify", {
        secret:  ENV['GOOGLE_RECAPTCHA_V2_SECRET_KEY'],
        response: token,
        **ip_option
      })

      json = JSON.parse(response.body)
      puts json unless json["success"]
      json
    end
  end
end
