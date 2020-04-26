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

%w[
  植松伸夫 すぎやまこういち 伊藤賢治 下村陽子 光田康典 古代祐三
  崎元仁 西木康智 谷岡久美 成田勤 土屋俊輔 上松範康 岡部啓一 祖堅正慶
  岩田匡治 いとうけいすけ なるけみちこ ピース flasygoodness 佐野信義
  ジェイク・カウフマン Inon\ Zur Austin\ Wintory Gareth\ Coker
  Jeremy\ Soule Kristofer\ Maddigan
  SQUARE\ ENIX\ MUSIC CAPCOM カプコン カプコンサウンドチーム アトラスサウンドチーム
  ファルコム・サウンド・チーム・JDK Falcom\ Sound\ Team\ jdk SNK\ サウンドチーム GUST クラリスディスク コナミ短形波倶楽部
  colopl INSIDE\ SYSTEM ジョーダウン namco namco\ sounds ベイシスケイプ
  Sony\ Computer\ Entertainment\ Inc.
].each do |name|
  puts "create artist #{name}".green
  start_time = Time.now

  Artist.create_by_name(name).map(&:create_albums)

  end_time = Time.now
  sec = (end_time - start_time).to_i
  puts "create finish #{name}, #{sec} sec".green
end

puts "seed 終了".red
