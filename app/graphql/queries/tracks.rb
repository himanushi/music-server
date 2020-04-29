module Queries
  class Tracks < BaseList
    description "曲一覧取得"

    type [Types::Objects::TrackType], null: false

    class TracksConditions < Types::InputObjects::BaseInputObject
      argument :tracks, IdInputObject, "トラックID", required: false
    end

    argument :conditions, TracksConditions, required: false, description: "取得条件"

    def query(limit:, offset:, order:, asc:, conditions: {})
      sort_type = asc ? :asc : :desc
      ::Track.include_services.where(status: [:pending, :active]).order({ "#{order}": sort_type }).distinct.offset(offset).limit(limit)
    end
  end
end
