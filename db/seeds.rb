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

["下村陽子", "西木康智", "植松伸夫", "伊藤賢治", "光田康典", "Inon Zur"].each do |name|
  puts "create #{name}".green
  start_time = Time.now

  Artist.create_by_name(name).map(&:create_albums)

  end_time = Time.now
  sec = (end_time - start_time).to_i
  puts "create finish #{name}, #{sec} sec".green
end

puts "seed 終了".red
