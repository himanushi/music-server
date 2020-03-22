module AppleMusicCreatable
  extend ActiveSupport::Concern

  module ClassMethods
    def create_by_apple_music_id(apple_music_id)
      type = self.name.gsub("AppleMusic", "").downcase
      body = AppleMusic::Client.new.__send__("get_#{type}", apple_music_id)
      data = body.try(:dig, "data", 0)
      id   = data.try(:[], "id")

      return [nil, {}] unless id.present?

      create_by_data(data)
    end

    def create_by_data(data)
      searched_record = find_by(apple_music_id: data["id"])
      attributes = mapping(data)

      result_record =
        if searched_record.present?
          searched_record.update!(attributes)
          searched_record
        else
          record = new(attributes)
          record.save!
          record
        end

      [result_record, data]
    end
  end
end
