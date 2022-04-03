# frozen_string_literal: true

class Cron
  class << self
    def execute
      # 有効なアーティストのアルバムを全件取得
      ::Artist.all_create_albums
      # 新アルバムを全件取得
      ::Album.create_by_new_releases
      # 昨日のPV数を登録
      ::PageViewLog.create_yesterday_data
      # 全てのテーブルのPVカラムを更新
      ::PageViewLog.update_page_view_colmuns
      # 人気度集計
      ::Popularity.tally
    end
  end
end
