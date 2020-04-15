module Types
  module Objects
    class ArtworkType < Types::Objects::BaseObject
      description 'アートワーク'

      field :url,    String, null: true, description: "URL"
      field :width,  PositiveNumber, null: true, description: "幅"
      field :height, PositiveNumber, null: true, description: "高さ"
    end
  end
end
