Rack::Attack.blocklist("Exclude the path of a vulnerability attack") do |request|
  path = YAML.load_file("config/blocklist/path.yml")["path"]
  ip = YAML.load_file("config/blocklist/ipsets.yml")["ipsets"]
  path.any? {|p| request.path.index(p) } || ip.any? {|i| request.ip.index(i) }
end
