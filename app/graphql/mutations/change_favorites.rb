# frozen_string_literal: true

module Mutations
  class ChangeFavorites < ::Mutations::BaseMutation
    description 'お気に入り一括変更'

    argument :ids, [::String], required: false, description: 'お気に入り変更したいID'
    argument :type, ::Types::Enums::FavoriteTypeEnum, required: false, description: 'お気に入り変更したいタイプ'
    argument :favorite,
             ::GraphQL::Types::Boolean,
             required: true,
             description: 'true の場合は一括でお気に入り登録をする。false 場合は一括で解除する。'

    field :current_user, ::Types::Objects::CurrentUserObject, null: true, description: '更新されたカレントユーザー'

    def mutate(favorite:, type:, ids: [])
      if favorite
        ::Favorite.register(user: context[:current_info][:user], type: type, ids: ids)
      else
        ::Favorite.unregister(user: context[:current_info][:user], type: type, ids: ids)
      end

      {
        current_user: context[:current_info][:user].reload
      }
    end
  end
end
