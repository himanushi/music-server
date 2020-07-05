class Favorite < ApplicationRecord
  table_id :fav

  belongs_to :favorable, polymorphic: true
end
