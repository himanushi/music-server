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

raise StandardError, "bundle exec rails db:migrate:reset をしてから実行してね" if User.exists?

puts "seed 開始".red

puts "user & role 作成".green

Role.create!(name: "admin", description: "管理者") do |role|
  AllowedAction::ALL_ACTIONS.each do |action_name|
    role.allowed_actions.new(name: action_name)
  end
end

Role.create!(name: "default", description: "初期ロール") do |role|
  AllowedAction::DEFAULT_ACTIONS.each do |action_name|
    role.allowed_actions.new(name: action_name)
  end
end

password = SecureRandom.hex(3)
puts "/signin [username: admin,  password: #{password}]".red
User.create!(
  name: "admin",
  username: "admin",
  description: "管理者ユーザ",
  role: Role.find_by!(name: "admin"),
  encrypted_password: BCrypt::Password.create(password, cost: 12)
)

puts "user & role 作成終了".green

if File.exists?("#{Rails.root.join("tmp", "vgm_db.dump")}")
  require 'rake'
  Rake::Task['db:restore'].execute
else
  YAML.load_file(Rails.root.join("db", "artists.yml")).each do |name|
    puts "create artist #{name}".green
    start_time = Time.now

    Artist.create_by_name(name).map(&:create_albums)

    end_time = Time.now
    sec = (end_time - start_time).to_i
    puts "create finish #{name}, #{sec} sec".green
  end
  Rake::Task['db:dump'].execute
end

puts "seed 終了".red
