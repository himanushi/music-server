module Queries
  class AlbumsCount < BaseCountQuery
    description "アルバム件数取得"

    type Integer, null: false

    class AlbumsCountConditionsInputObject < BaseInputObject
      argument :usernames, [String], "ユーザー名", required: false
      argument :artists,   IdInputObject, "アーティストID", required: false
      argument :tracks,    IdInputObject, "トラックID", required: false
      argument :name,      String, "アルバム名(あいまい検索)", required: false
      argument :status,    [StatusEnum], "表示ステータス", required: false
      argument :favorite,  Boolean, "お気に入り", required: false
    end

    argument :conditions, AlbumsCountConditionsInputObject, required: false, description: "取得条件"

    def count_query(conditions: {})
      album_relation, conditions, is_cache = Queries::Albums.build_relation(conditions: conditions, context: context)

      [
        is_cache,
        album_relation.where(conditions)
      ]
    end
  end
end
