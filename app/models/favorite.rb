# frozen_string_literal: true

class Favorite < ::ApplicationRecord
  def table_id() = 'fav'

  belongs_to :favorable, polymorphic: true
  belongs_to :user

  class << self
    def register(favorites, user)
      ::ActiveRecord::Base.transaction do
        favorites.each { |favorite| find_or_create_by(favorable: favorite, user: user) }
      end
    end

    def unregister(favorites, user)
      ::ActiveRecord::Base.transaction do
        where(favorable: favorites, user: user).destroy_all
      end
    end
  end
end
