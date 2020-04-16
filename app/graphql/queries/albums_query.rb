module Queries
  class AlbumsQuery < BaseListQuery
    description "アルバム一覧取得"

    type [Types::Objects::AlbumType], null: false

    class AlbumsQueryOrder < Types::BaseEnum
      value "NAME",    value: "name",         description: "名前順"
      value "NEW",     value: "created_at",   description: "新しい順"
      value "RELEASE", value: "release_date", description: "発売日順"
    end

    argument :order,  AlbumsQueryOrder, required: true, description: "ソート対象"

    def resolve(limit:, offset:, order:, asc:)
      sort_type = asc ? :asc : :desc
      Album.include_services.offset(offset).limit(limit).order({ "#{order}": sort_type })
    end
  end
end
