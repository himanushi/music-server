# frozen_string_literal: true

module Types
  module Objects
    class UserObject < ::Types::Objects::BaseObject
      description 'ユーザー'

      field :id,   ::String, null: false, description: 'ID'
      field :name, ::String, null: false, description: '名前'
      field :username, ::String, null: false, description: 'ユーザー名'
    end
  end
end
