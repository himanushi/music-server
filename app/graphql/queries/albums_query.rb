# frozen_string_literal: true

module Queries
  class AlbumsQuery < ::Queries::BaseListQuery
    description 'アルバム一覧取得'

    type [::Types::Objects::AlbumObject], null: true

    class AlbumsQueryOrderEnum < ::Types::Enums::BaseEnum
      value 'NEW',        value: 'albums.created_at', description: '追加順'
      value 'RELEASE',    value: 'albums.release_date', description: '発売日順'
      value 'POPULARITY', value: 'albums.popularity', description: '人気順'
    end

    class AlbumsSortInputObject < ::Types::InputObjects::BaseInputObject
      argument :order,
               ::Queries::AlbumsQuery::AlbumsQueryOrderEnum,
               required: false,
               default_value: ::Queries::AlbumsQuery::AlbumsQueryOrderEnum.values['RELEASE'].value,
               description: '並び順対象'
      argument :direction,
               ::Types::Enums::SortEnum,
               required: false,
               default_value: ::Types::Enums::SortEnum.values['DESC'].value,
               description: '並び順'
    end

    class AlbumsConditionsInputObject < ::Types::InputObjects::BaseInputObject
      argument :artist_ids, [::String], required: false, description: 'アーティストID'
      argument :track_ids,  [::String], required: false, description: 'トラックID'
      argument :name,       ::String, required: false, description: 'アルバム名(あいまい検索)'
      argument :status,     [::Types::Enums::StatusEnum], required: false, description: '表示ステータス'
      argument :favorite,   ::GraphQL::Types::Boolean, required: false, description: 'お気に入り'
    end

    argument :cursor,
             ::Types::InputObjects::CursorInputObject,
             required: false,
             description: '取得件数',
             default_value: ::Types::InputObjects::CursorInputObject.default_argument_values
    argument :sort,
             ::Queries::AlbumsQuery::AlbumsSortInputObject,
             required: false,
             description: '取得順',
             default_value: ::Queries::AlbumsQuery::AlbumsSortInputObject.default_argument_values
    argument :conditions, ::Queries::AlbumsQuery::AlbumsConditionsInputObject, required: false, description: '取得条件'

    def query_class() = ::Album
  end
end
