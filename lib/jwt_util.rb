class JwtUtil
  class << self
    def encode(object)
      object = { **object, exp: Session::EXPIRE_DAYS.from_now.to_i }.deep_symbolize_keys
      JWT.encode(object, ENV["SECRET_KEY_BASE"], 'HS512')
    end

    def decode(object)
      decoded_object = JWT.decode(object, ENV["SECRET_KEY_BASE"], true, algorithm: 'HS512')
      decoded_object.first
    end
  end
end
