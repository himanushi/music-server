# frozen_string_literal: true

module Queries
  class PlaylistsQuery < ::Queries::BaseListQuery
    description 'プレイリスト一覧取得'

    type [::Types::Objects::PlaylistObject], null: true

    class PlaylistsQueryOrderEnum < ::Types::Enums::BaseEnum
      value 'NEW',        value: 'playlists.created_at', description: '作成日順'
      value 'UPDATE',     value: 'playlists.updated_at', description: '更新日順'
      value 'POPULARITY', value: 'playlists.popularity', description: '人気順'
    end

    class PlaylistsSortInputObject < ::Types::InputObjects::BaseInputObject
      argument :order,
               ::Queries::PlaylistsQuery::PlaylistsQueryOrderEnum,
               required: false,
               default_value: ::Queries::PlaylistsQuery::PlaylistsQueryOrderEnum.values['UPDATE'].value,
               description: '並び順対象'
      argument :direction,
               ::Types::Enums::SortEnum,
               required: false,
               default_value: ::Types::Enums::SortEnum.values['DESC'].value,
               description: '並び順'
    end

    class PlaylistsConditionsInputObject < ::Types::InputObjects::BaseInputObject
      argument :name,     ::String, 'プレイリスト名( like 検索)', required: false
      argument :is_mine,  ::GraphQL::Types::Boolean, '自身のプレイリスト取得', required: false, default_value: false
      argument :favorite, ::GraphQL::Types::Boolean, 'お気に入り', required: false
    end

    argument :cursor,
             ::Types::InputObjects::CursorInputObject,
             required: false,
             description: '取得件数',
             default_value: ::Types::InputObjects::CursorInputObject.default_argument_values
    argument :sort,
             ::Queries::PlaylistsQuery::PlaylistsSortInputObject,
             required: false,
             description: '取得順',
             default_value: ::Queries::PlaylistsQuery::PlaylistsSortInputObject.default_argument_values
    argument :conditions,
             ::Queries::PlaylistsQuery::PlaylistsConditionsInputObject,
             required: false,
             description: '取得条件'

    def query_class() = ::Playlist
  end
end
