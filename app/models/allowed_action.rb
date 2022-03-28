# frozen_string_literal: true

class AllowedAction < ::ApplicationRecord
  def table_id = 'ald'

  belongs_to :role

  validates :name, :role, presence: true
  validates :name, inclusion: { in: ->(_) { ::AllowedAction.all_actions }, message: '指定できないアクション(%<value>)' }

  class << self
    def default_actions = ::Query.fields.keys + %w[login signup]

    def console_actions = %w[graphiql console].freeze

    def all_actions = (::Mutation.fields.keys + default_actions + console_actions).uniq
  end
end

module Types
  module Enums
    class ActionEnum < ::Types::Enums::BaseEnum
      ::AllowedAction.all_actions.each do |action|
        value action, value: action
      end
    end
  end
end
