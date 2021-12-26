# frozen_string_literal: true

module Queries
  class ArtistsQuery < ::Queries::BaseListQuery
    description 'アーティスト一覧取得'

    type [::Types::Objects::ArtistObject], null: true

    class ArtistsQueryOrderEnum < ::Types::Enums::BaseEnum
      value 'NAME',       value: 'artists.name', description: '名前順'
      value 'NEW',        value: 'artists.created_at', description: '追加順'
      value 'POPULARITY', value: 'artists.popularity', description: '人気順'
    end

    class ArtistsSortInputObject < ::Types::InputObjects::BaseInputObject
      argument :order,
               ::Queries::ArtistsQuery::ArtistsQueryOrderEnum,
               required: false,
               default_value: ::Queries::ArtistsQuery::ArtistsQueryOrderEnum.values['NEW'].value,
               description: '並び順対象'
      argument :direction,
               ::Types::Enums::SortEnum,
               required: false,
               default_value: ::Types::Enums::SortEnum.values['DESC'].value,
               description: '並び順'
    end

    class ArtistsConditionsInputObject < ::Types::InputObjects::BaseInputObject
      argument :album_ids, [::String], required: false, description: 'アルバムID'
      argument :track_ids, [::String], required: false, description: 'トラックID'
      argument :name,      ::String, required: false, description: 'アーティスト名(あいまい検索)'
      argument :status,    [::Types::Enums::StatusEnum], required: false, description: '表示ステータス'
      argument :favorite,  ::GraphQL::Types::Boolean, required: false, description: 'お気に入り'
    end

    argument :cursor,
             ::Types::InputObjects::CursorInputObject,
             required: false,
             description: '取得件数',
             default_value: ::Types::InputObjects::CursorInputObject.default_argument_values
    argument :sort,
             ::Queries::ArtistsQuery::ArtistsSortInputObject,
             required: false,
             description: '取得順',
             default_value: ::Queries::ArtistsQuery::ArtistsSortInputObject.default_argument_values
    argument :conditions, ::Queries::ArtistsQuery::ArtistsConditionsInputObject, required: false, description: '取得条件'

    def query_class() = ::Artist
  end
end
