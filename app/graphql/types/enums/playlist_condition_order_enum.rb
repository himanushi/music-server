# frozen_string_literal: true

module Types
  module Enums
    class PlaylistConditionOrderEnum < ::Types::Enums::BaseEnum
      value 'POPULARITY', value: 'popularity', description: '人気順'
      value 'RELEASE_DATE', value: 'release_date', description: '配信日順'
      value 'CREATED_AT', value: 'created_at', description: '作成日順'
    end
  end
end
