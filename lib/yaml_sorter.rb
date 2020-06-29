class YamlSorter
  def self.sort(file_path)
    data = YAML.load_file(file_path)

    sorted_data =
      data.map do |k, v|
        if !(IPAddr.new(v.first) rescue nil).nil?
          [k, v.sort_by {|ip| ip.split(".").map {|i| i.to_i } }]
        else
          [k, v.sort]
        end
      end.to_h

    File.open(file_path, 'w') {|f| YAML.dump(sorted_data, f) }
  end

  def self.sort_blocklist
    sort("config/blocklist/ipsets.yml")
    sort("config/blocklist/path.yml")
  end
end
