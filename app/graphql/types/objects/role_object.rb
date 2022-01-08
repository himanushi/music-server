# frozen_string_literal: true

module Types
  module Objects
    class RoleObject < ::Types::Objects::BaseObject
      description 'ロール'

      field :id,              ::String, null: false, description: 'ID'
      field :name,            ::String, null: false, description: '名前'
      field :description,     ::String, null: false, description: '説明'
      field :allowed_actions, [::Types::Enums::ActionEnum], null: false, description: '出来ること一覧'

      def allowed_actions() = object.allowed_actions.map(&:name)
    end
  end
end
