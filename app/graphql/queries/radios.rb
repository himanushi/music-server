module Queries
  class Radios < BaseListQuery
    description "ラジオ一覧取得"

    type [RadioType], null: false

    class RadiosQueryOrderEnum < BaseEnum
      value "NEW", value: "radios.created_at", description: "作成日順"
      value "POPULARITY", value: "radios.popularity", description: "人気順"
    end

    class RadiosSortInputObject < BaseInputObject
      argument :order, RadiosQueryOrderEnum, required: false, default_value: RadiosQueryOrderEnum.values["POPULARITY"].value, description: "並び順対象"
      argument :type,  SortEnum, required: false, default_value: SortEnum.values["DESC"].value, description: "並び順"
    end

    class RadiosConditionsInputObject < BaseInputObject
      argument :name, String, "ラジオ名( like 検索)", required: false
      argument :favorite,  Boolean, "お気に入り", required: false
    end

    argument :cursor, CursorInputObject, required: false, description: "取得件数", default_value: CursorInputObject.default_argument_values
    argument :sort, RadiosSortInputObject, required: false, description: "取得順", default_value: RadiosSortInputObject.default_argument_values
    argument :conditions, RadiosConditionsInputObject, required: false, description: "取得条件"

    def list_query(cursor:, sort:, conditions: {})
      conditions = { **conditions }
      relation = ::Radio.include_playlists

      # お気に入り検索
      if conditions.delete(:favorite)
        relation =
          relation.joins(:favorites).where(favorites: { user_id: context[:current_info][:user].id })
      end

      # 名前あいまい検索
      if conditions.has_key?(:name)
        name = conditions.delete(:name)
        relation = relation.joins(:playlist).where("playlists.name like :name", name: "%#{name}%")
      end

      [
        is_cache = false,
        relation.where(conditions).
          order([{ order => sort_type }, { id: sort_type }]).
          distinct.offset(offset).limit(limit)
      ]
    end
  end
end
