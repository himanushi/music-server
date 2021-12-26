# frozen_string_literal: true

module Types
  module Objects
    class ArtworkObject < ::Types::Objects::BaseObject
      description 'アートワーク'

      field :url,    ::String, null: true, description: 'URL'
      field :width,  ::Integer, null: true, description: '幅'
      field :height, ::Integer, null: true, description: '高さ'
    end
  end
end
