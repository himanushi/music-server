module Dokku
  class << self
    def configs
      params = File.open('.env').read.gsub(/=("|)/, '="').gsub(/("|)\n/, '" ').gsub('RAILS_ENV="development"', 'RAILS_ENV="production"')
      print "dokku config:set music-server #{params}"
    end

    def keys
      print File.open('.env').read.split("\n").map{|p|p.gsub(/=.*/, "")}.join("\n")
    end
  end
end
