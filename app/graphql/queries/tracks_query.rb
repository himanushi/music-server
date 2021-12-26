# frozen_string_literal: true

module Queries
  class TracksQuery < ::Queries::BaseListQuery
    description 'トラック一覧取得'

    type [::Types::Objects::TrackObject], null: true

    class TracksQueryOrderEnum < ::Types::Enums::BaseEnum
      value 'NEW', value: 'tracks.created_at', description: '追加順'
      value 'POPULARITY', value: 'tracks.popularity', description: '人気順'
    end

    class TracksSortInputObject < ::Types::InputObjects::BaseInputObject
      argument :order,
               ::Queries::TracksQuery::TracksQueryOrderEnum,
               required: false,
               default_value: ::Queries::TracksQuery::TracksQueryOrderEnum.values['NEW'].value,
               description: '並び順対象'
      argument :direction,
               ::Types::Enums::SortEnum,
               required: false,
               default_value: ::Types::Enums::SortEnum.values['DESC'].value,
               description: '並び順'
    end

    class TracksConditionsInputObject < ::Types::InputObjects::BaseInputObject
      argument :name,     ::String, 'トラック名(あいまい検索)', required: false
      argument :status,   [::Types::Enums::StatusEnum], '表示ステータス', required: false
      argument :favorite, ::GraphQL::Types::Boolean, 'お気に入り', required: false
      argument :random,   ::GraphQL::Types::Boolean, 'ランダム取得', required: false
    end

    argument :cursor,
             ::Types::InputObjects::CursorInputObject,
             required: false,
             description: '取得件数',
             default_value: ::Types::InputObjects::CursorInputObject.default_argument_values
    argument :sort,
             ::Queries::TracksQuery::TracksSortInputObject,
             required: false,
             description: '取得順',
             default_value: ::Queries::TracksQuery::TracksSortInputObject.default_argument_values
    argument :conditions, ::Queries::TracksQuery::TracksConditionsInputObject, required: false, description: '取得条件'

    def query_class() = ::Track
  end
end
