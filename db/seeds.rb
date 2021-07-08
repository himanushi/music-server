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

puts "seed 開始".red

Role.create!(name: "admin", description: "管理者") do |role|
  AllowedAction::ALL_ACTIONS.each do |action_name|
    role.allowed_actions.new(name: action_name)
  end
end

Role.create!(name: "default", description: "未ログイン") do |role|
  AllowedAction::DEFAULT_ACTIONS.each do |action_name|
    role.allowed_actions.new(name: action_name)
  end
end

Role.create!(name: "login", description: "ログイン済み") do |role|
  AllowedAction::DEFAULT_ACTIONS.each do |action_name|
    role.allowed_actions.new(name: action_name)
  end
end

password = SecureRandom.hex(3)

puts "/login [username: admin,  password: #{password}]".red
User.create!(
  name: "admin",
  username: "admin",
  description: "管理者ユーザ",
  role: Role.find_by!(name: "admin"),
  encrypted_password: BCrypt::Password.create(password, cost: 12)
)

puts "seed 終了".red
