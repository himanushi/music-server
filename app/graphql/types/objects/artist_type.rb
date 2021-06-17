module Types
  module Objects
    class ArtistType < Types::Objects::BaseObject
      description 'アーティスト'

      field :id,                  TTID, null: false, description: "ID"
      field :name,                String, null: false, description: "名前"
      field :status,              StatusEnum, null: false, description: "ステータス"
      field :release_date,        GraphQL::Types::ISO8601DateTime, null: false, description: "発売日"
      field :created_at,          GraphQL::Types::ISO8601DateTime, null: false, description: "追加日"
      field :artwork_l,           ArtworkType, null: false, description: "大型アートワーク"
      field :artwork_m,           ArtworkType, null: false, description: "中型アートワーク"

      def artwork_l
        return Artwork.new unless object.service.present?
        object.service.artwork_l
      end

      def artwork_m
        return Artwork.new unless object.service.present?
        object.service.artwork_m
      end
    end
  end
end
