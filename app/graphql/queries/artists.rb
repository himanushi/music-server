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
        albums = ::Album.include_artists.include_tracks.where(id: conditions.delete(:albums)[:id])
        artist_ids = albums.map {|a| a.artists.ids }.flatten
        artist_ids += albums.map {|a| a.tracks.include_artists.map {|t| t.artists.ids } }.flatten
        conditions[:id] = artist_ids.uniq
      end

      cache_key = { where: conditions, order: {  "#{order}": sort_type }, limit: limit, offset: offset }.to_s

      # ステータス以外の条件は容量が多くなるためキャッシュしない
      if conditions.except(:status).keys.present?
        artist_relation.where({ **conditions }).
        order({ "#{order}": sort_type }).distinct.offset(offset).limit(limit)
      elsif Rails.cache.exist?(cache_key)
        Rails.cache.read(cache_key)
      else
        artists =
          artist_relation.where({ **conditions }).
          order({ "#{order}": sort_type }).distinct.offset(offset).limit(limit).load
        Rails.cache.write(cache_key, artists)
        artists
      end
    end
  end
end
