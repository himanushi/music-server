# frozen_string_literal: true

class ChangeColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column(:users, :encrypted_password, :password_digest)
    add_column(:users, :registered, :boolean, null: false, index: true, default: false)
  end
end
