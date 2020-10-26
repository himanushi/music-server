module Types
  module Objects
    class SpotifyTokenType < Types::Objects::BaseObject
      description 'Spotify Token'

      field :access_token, String, null: false
      field :token_type, String, null: false
      field :expires_in, Integer, null: false
      field :refresh_token, String, null: true
      field :scope, String, null: false
    end
  end
end
