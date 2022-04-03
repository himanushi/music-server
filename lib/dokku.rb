# frozen_string_literal: true

module Dokku
  class << self
    def configs(env = '')
      file_name, app_name =
        if env.present?
          [".env.#{env}", env]
        else
          ['.env', 'music-server']
        end

      params = ::File.read(file_name).gsub(/\n/, ' ').gsub('RAILS_ENV="development"', 'RAILS_ENV="production"')
      print("dokku config:set #{app_name} #{params}")
    end

    def keys
      print(
        ::File.read('.env').split("\n").map { |p| p.gsub(/=.*/, '') }
        .join("\n")
      )
    end
  end
end
