# frozen_string_literal: true

module Mutations
  class UpdateMe < ::Mutations::BaseMutation
    description 'カレントユーザー情報更新'

    argument :name, ::String, required: false

    field :current_user, ::Types::Objects::CurrentUserObject, null: true

    def mutate(name:)
      context[:current_info][:user].update!(name: name)

      {
        current_user: context[:current_info][:user].reload
      }
    end
  end
end
