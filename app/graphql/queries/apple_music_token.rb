module Queries
  class AppleMusicToken < BaseQuery
    description "Apple Music Token"

    type String, null: false

    def query
      AppleMusic::Token.create_client_token[:access_token]
    end
  end
end
