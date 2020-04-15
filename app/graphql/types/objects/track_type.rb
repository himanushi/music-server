module Types
  module Objects
    class TrackType < Types::Objects::BaseObject
      description 'トラック'

      field :id,                TTID, null: false, description: "ID"
      field :isrc,              String, null: false, description: "国際標準レコーディングコード"
      field :name,              String, null: false, description: "タイトル"

      def name
        object.service.name
      end
    end
  end
end
