# frozen_string_literal: true

module Types
  module Enums
    class PlaylistPublicTypeEnum < ::Types::Enums::BaseEnum
      value 'OPEN', value: 'open', description: '公開'
      value 'NON_OPEN', value: 'non_open', description: '非公開'
      value 'ANONYMOUS_OPEN', value: 'anonymous_open', description: '匿名公開'
    end
  end
end
