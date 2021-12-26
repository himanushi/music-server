# frozen_string_literal: true

module Queries
  class AppleMusicTokenQuery < ::Queries::BaseQuery
    description 'Apple Music Token'

    type ::String, null: false

    def query
      ::AppleMusic::Token.create_client_token[:access_token]
    end
  end
end
