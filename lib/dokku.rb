module Dokku
  class << self
    def configs(env = "")
      file_name, app_name =
        if env.present?
          [".env.#{env}", env]
        else
          [".env", "music-server"]
        end

      params = File.open(file_name).read.gsub(/=("|)/, '="').gsub(/("|)\n/, '" ').gsub('RAILS_ENV="development"', 'RAILS_ENV="production"')
      print "dokku config:set #{app_name} #{params}"
    end

    def keys
      print File.open(".env").read.split("\n").map{|p|p.gsub(/=.*/, "")}.join("\n")
    end
  end
end
