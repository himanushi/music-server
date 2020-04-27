class User < ApplicationRecord
  table_id :user

  include Users::Authenticator

  validates :name, :username, :token, presence: true
  validates :username, uniqueness: true, format: { with: /\A[0-9a-zA-Z]+\z/, message: "半角英数字のみが使えます" }
end
