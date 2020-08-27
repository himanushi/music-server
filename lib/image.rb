class Image
  class << self
    def fetch_actual_size(url)
      return [nil, nil] unless url.present?

      image = MiniMagick::Image.open(url)
      [image.width, image.height]
    rescue
      [nil, nil]
    end
  end
end
