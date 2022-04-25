# frozen_string_literal: true

class PlaylistCondition < ::ActiveRecord::Base
  belongs_to :playlist

  enum order: { popularity: 0, release_date: 1, name: 2 }, _prefix: true
  enum direction: { asc: 0, desc: 1 }, _prefix: true
end
