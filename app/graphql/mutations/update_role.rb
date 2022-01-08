# frozen_string_literal: true

module Mutations
  class UpdateRole < ::Mutations::BaseMutation
    description 'ロールを追加更新する'

    argument :role_id, ::String, required: true, description: '変更したいロール。IDを指定しない場合は追加される'
    argument :name, ::String, required: false, description: 'ロール名。IDを指定しない場合は必須。'
    argument :description, ::String, required: false, description: 'ロールの説明。IDを指定しない場合は必須。'
    argument :allowed_actions,
             [::Types::Enums::ActionEnum],
             required: false,
             description: '変更したいアクション。全て上書きされる。IDを指定しない場合は必須。'

    field :role, ::Types::Objects::RoleObject, null: true, description: '追加更新されたロール'

    def mutate(role_id:, name: nil, description: nil, allowed_actions: [])
      # @type var actions: ::Array[::AllowedAction]
      actions = allowed_actions.map { |action_name| ::AllowedAction.new(name: action_name) }

      # @type var role: ::Role
      role = ::Role.find(role_id)
      role.name = name if name
      role.description = description if description
      if actions.present?
        role.allowed_actions = []
        role.allowed_actions = actions
      end
      role.save!

      ::Rails.cache.clear

      { role: role }
    end
  end
end
