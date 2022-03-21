# frozen_string_literal: true

class InsertIgnoreContent < ::ActiveRecord::Migration[7.0]
  def change
    %w[571229692 571227493 571273814 571218770 571275129].each do |music_service_id|
      ::IgnoreContent.create!(music_service_id: music_service_id, reason: '別バージョン対応')
    rescue ::StandardError
      false
    end
  end
end
