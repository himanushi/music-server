module Queries
  class Artists < BaseListQuery
    description "アーティスト一覧取得"

    type [ArtistType], null: false

    class ArtistsQueryOrderEnum < BaseEnum
      value "NAME",       value: "artists.name", description: "名前順"
      value "NEW",        value: "artists.created_at", description: "追加順"
      value "POPULARITY", value: "spotify_artists.popularity", description: "人気順"
    end

    class ArtistsSortInputObject < BaseInputObject
      argument :order,  ArtistsQueryOrderEnum, required: false, default_value: ArtistsQueryOrderEnum.values["NAME"].value,description: "ソート対象"
      argument :type,   SortEnum, required: false, default_value: SortEnum.values["ASC"].value, description: "並び順"
    end

    class ArtistsConditionsInputObject < BaseInputObject
      argument :albums, IdInputObject, "アルバムID", required: false
      argument :status, [StatusEnum], "表示ステータス", required: false
    end

    argument :cursor, CursorInputObject, required: false, description: "取得件数", default_value: CursorInputObject.default_argument_values
    argument :sort, ArtistsSortInputObject, required: false, description: "取得順", default_value: ArtistsSortInputObject.default_argument_values
    argument :conditions, ArtistsConditionsInputObject, required: false, description: "取得条件"

    def list_query(cursor:, sort:, conditions: {})
      conditions = { status: [:active], **conditions }
      artist_relation = ::Artist.include_services

      if conditions.has_key?(:albums)
        albums = ::Album.include_artists.include_tracks.where(id: conditions.delete(:albums)[:id])
        artist_ids = albums.map {|a| a.artists.ids }.flatten
        artist_ids += albums.map {|a| a.tracks.include_artists.map {|t| t.artists.ids } }.flatten
        conditions[:id] = artist_ids.uniq
      end

      artist_relation.where({ **conditions }).
        order({ order => sort_type }).distinct.offset(offset).limit(limit)
    end
  end
end
