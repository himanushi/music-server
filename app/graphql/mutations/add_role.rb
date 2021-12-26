# frozen_string_literal: true

module Mutations
  class AddRole < ::Mutations::BaseMutation
    description 'ロールを追加する'

    argument :name, ::String, required: true, description: 'ロール名。IDを指定しない場合は必須。'
    argument :description, ::String, required: true, description: 'ロールの説明。IDを指定しない場合は必須。'
    argument :allowed_actions,
             [::Types::Enums::ActionEnum],
             required: true,
             description: '変更したいアクション。全て上書きされる。IDを指定しない場合は必須。'

    field :role, ::Types::Objects::RoleObject, null: true, description: '追加更新されたロール'

    def mutate(name:, description:, allowed_actions:)
      # @type var actions: ::Array[::AllowedAction]
      actions = allowed_actions.map { |action_name| ::AllowedAction.new(name: action_name) }

      # @type var role: ::Role
      role = ::Role.new(name: name, description: description, allowed_actions: actions)
      role.save!

      ::Rails.cache.clear

      {
        role: role
      }
    end
  end
end
