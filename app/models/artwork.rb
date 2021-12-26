# frozen_string_literal: true

class Artwork
  include ::ActiveModel::Model
  include ::ActiveModel::Attributes

  attribute :url,    :string
  attribute :width,  :integer
  attribute :height, :integer
end
