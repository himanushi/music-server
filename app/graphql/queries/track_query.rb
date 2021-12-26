# frozen_string_literal: true

module Queries
  class TrackQuery < ::Queries::BaseQuery
    description 'トラック情報取得'

    type ::Types::Objects::TrackObject, null: true

    argument :id, ::String, required: true, description: 'トラックID'

    def query(id:) = ::Track.find_by(id: id)
  end
end
