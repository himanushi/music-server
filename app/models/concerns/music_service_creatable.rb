module MusicServiceCreatable
  extend ActiveSupport::Concern

  module ClassMethods
    def find_or_create_by_music_service_id(music_service_id)
      record = find_by(spotify_id: music_service_id)
      return record unless record.nil?

      ActiveRecord::Base.transaction { create_by_music_service_id(music_service_id) }
    end

    def create_by_music_service_id(music_service_id)
      raise NotImplementedError
    end

    def create_or_update_by_data(music_service_id, data)
      searched_record = find_by("#{music_service_id_name}": music_service_id)
      attributes = mapping(data)

      result_record =
        if searched_record.present?
          searched_record.update!(attributes)
          searched_record
        else
          record = new(attributes)
          begin
            record.save!
          rescue ActiveRecord::RecordNotUnique => error
            IgnoreContent.create!(
              music_service_id: music_service_id,
              error_class: "ActiveRecord::RecordNotUnique",
              error_log: error.message
            )
            return nil
          end
          record
        end

      result_record
    end

    def music_service_id_name
      raise NotImplementedError
    end
  end
end
