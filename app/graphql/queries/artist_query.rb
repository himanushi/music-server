# frozen_string_literal: true

module Queries
  class ArtistQuery < ::Queries::BaseQuery
    description 'アーティスト取得'

    type ::Types::Objects::ArtistObject, null: true

    argument :id, ::String, required: true, description: 'ID'

    def query(id:) = ::Artist.find_by(id: id)
  end
end
