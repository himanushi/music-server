module Dokku
  class << self
    def configs(env = "")
      params = File.open(".env#{env}").read.gsub(/=("|)/, '="').gsub(/("|)\n/, '" ').gsub('RAILS_ENV="development"', 'RAILS_ENV="production"')
      print "dokku config:set music-server #{params}"
    end

    def keys(env = "")
      print File.open(".env#{env}").read.split("\n").map{|p|p.gsub(/=.*/, "")}.join("\n")
    end
  end
end
