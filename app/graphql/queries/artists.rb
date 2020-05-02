module Queries
  class Artists < BaseList
    description "アーティスト一覧取得"

    type [Types::Objects::ArtistType], null: false

    class ArtistsQueryOrder < Types::Enums::BaseEnum
      value "NEW",        value: "artists.created_at", description: "新しい順"
      value "POPULARITY", value: "spotify_artists.popularity", description: "人気順"
    end

    class ArtistsConditions < BaseInputObject
      argument :albums, IdInputObject, "アルバムID", required: false
      argument :status, [Types::Enums::StatusEnum], "表示ステータス", required: false
    end

    argument :conditions, ArtistsConditions, required: false, description: "取得条件"
    argument :order, ArtistsQueryOrder, required: false, description: "ソート対象"

    def query(limit:, offset:, order:, asc:, conditions: {})
      conditions = { status: ["pending", "active"], **conditions }
      sort_type = asc ? :asc : :desc

      artist_relation = ::Artist.include_services

      if conditions.has_key?(:albums)
        artist_ids =
          ::Album.include_tracks.where(id: conditions.delete(:albums)[:id]).first.
          tracks.include_artists.map{|t| t.artists.ids }.flatten.uniq
        conditions[:id] = artist_ids
      end

      artist_relation.where({ status: [:pending, :active], **conditions }).
      order({ "#{order}": sort_type }).distinct.offset(offset).limit(limit)
    end
  end
end
