# frozen_string_literal: true

class String
  # colorization
  # ref: https://stackoverflow.com/questions/1489183/colorized-ruby-output
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end
end

puts 'seed 開始'.red

::ActiveRecord::Base.transaction do
  ::Role.create!(name: 'admin', description: '管理者') do |role|
    ::AllowedAction.all_actions.each do |action_name|
      role.allowed_actions.new(name: action_name)
    end
  end

  ::Role.create!(name: 'default', description: '未ログイン') do |role|
    ::AllowedAction.default_actions.each do |action_name|
      role.allowed_actions.new(name: action_name)
    end
  end

  ::Role.create!(name: 'login', description: 'ログイン済み') do |role|
    ::AllowedAction.default_actions.each do |action_name|
      role.allowed_actions.new(name: action_name)
    end
  end

  password = "#{::SecureRandom.hex(3)}aA1"
  username = ::SecureRandom.hex(3)

  puts "/login [username: #{username},  password: #{password}]".green
  ::User.create!(name: 'admin', username: username, role: ::Role.find_by!(name: 'admin'), password: password)
end

puts 'seed 終了'.red
