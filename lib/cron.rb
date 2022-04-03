# frozen_string_literal: true

class Cron
  class << self
    def execute
      # 有効なアーティストのアルバムを全件取得
      ::Artist.all_create_albums
      # 新アルバムを全件取得
      ::Album.create_by_new_releases
      # Analytics 集計
      ::Ggl::Analytics.all
      # 人気度集計
      ::Popularity.tally
    end
  end
end
