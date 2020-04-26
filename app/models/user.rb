class User < ApplicationRecord
  table_id :user

  include Users::Authenticator

  validates :name, presence: true
end
