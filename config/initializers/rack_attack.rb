Rack::Attack.blocklist("Exclude the path of a vulnerability attack") do |request|
  path = YAML.load_file("config/blocklist/path.yml")["path"]
  path.any? {|p| request.path.index(p) }
end
