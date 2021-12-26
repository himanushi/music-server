# frozen_string_literal: true

module Types
  module Objects
    class CurrentUserObject < ::Types::Objects::BaseObject
      description 'カレントユーザー'

      field :id,   ::String, null: false, description: 'ID'
      field :name, ::String, null: false, description: '名前'
      field :username, ::String, null: false, description: 'ユーザー名'
      field :role, ::Types::Objects::RoleObject, null: false, description: 'ロール'
      field :favorite, ::Types::Objects::FavoriteObject, null: false, description: 'お気に入り'
      field :registered, ::GraphQL::Types::Boolean, null: false, description: '登録済み'

      def name() = object.registered ? object.name : ''

      def username() = object.registered ? object.username : ''
    end
  end
end
