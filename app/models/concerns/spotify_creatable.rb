module SpotifyCreatable
  extend ActiveSupport::Concern

  module ClassMethods
    def find_or_create_by_spotify_id(spotify_id)
      record = find_by(spotify_id: spotify_id)
      return record unless record.nil?

      ActiveRecord::Base.transaction { create_by_spotify_id(spotify_id) }
    end

    def create_by_spotify_id(spotify_id)
      raise NotImplementedError
    end

    def create_by_data(data)
      searched_record = find_by(spotify_id: data["id"])
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

      result_record
    end
  end
end
