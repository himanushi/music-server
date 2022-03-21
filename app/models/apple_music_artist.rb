# frozen_string_literal: true

class AppleMusicArtist < ::ApplicationRecord
  def table_id() = 'ama'

  belongs_to :artist
  # Apple Music ID: 12906, Error: Mysql2::Error: Data too long for column 'name' at row 1
  # Apple Music ID: 208472504, Error: Mysql2::Error: Duplicate entry 'JPCO09821010' for key 'index_tracks_on_isrc'
  # Apple Music ID: 74064473, Error: undefined method `[]' for nil:NilClass
  # Apple Music ID: 151385495, Error: undefined method `[]' for nil:NilClass
  # Apple Music ID: 1516371319, Error: Mysql2::Error: Data too long for column 'name' at row 1
  # Apple Music ID: 290568908, Error: undefined method `[]' for nil:NilClass
  # Apple Music ID: 291365220, Error: undefined method `[]' for nil:NilClass
  # Apple Music ID: 1277565947, Error: undefined method `[]' for nil:NilClass
  # Apple Music ID: 1267094116, Error: undefined method `[]' for nil:NilClass
  # Apple Music ID: 1080909084, Error: undefined method `[]' for nil:NilClass
  # Apple Music ID: 1258995350, Error: undefined method `[]' for nil:NilClass
  # Apple Music ID: 1226561403, Error: undefined method `[]' for nil:NilClass
  # Apple Music ID: 1513322647, Error: undefined method `[]' for nil:NilClass
  # Apple Music ID: 1444590736, Error: undefined method `[]' for nil:NilClass
  def create_albums
    # @type var albums_ids: ::Array[::String]
    albums_ids = []

    alums_data = ::AppleMusic::Api.new.get_artist_albums(apple_music_id)['data']
    albums_ids += alums_data.map { |album| album['id'] } if alums_data.present?

    # V.A などの取得不可なアルバムに対応するため携わっているトラックからアルバムを取得する
    tracks_data = ::AppleMusic::Api.new.get_artist_tracks(apple_music_id)['data']
    if tracks_data.present?
      # 以下のようなURLからアルバムIDを抽出
      # https://music.apple.com/jp/album/999999999?i=999999999
      # https://music.apple.com/jp/album/アルバム名/999999999?i=999999999
      # TODO: 型検証のために空文字を追加しているがダメなのでなんとかする
      albums_ids += tracks_data.map { |track| track['attributes']['url'][%r{/([0-9]+)\?}, 1] || '' }
    end

    return [] if albums_ids.empty?

    albums_ids.uniq.map do |albums_id|
      ::ActiveRecord::Base.transaction do
        ::AppleMusic::Album.create_full(albums_id)
      end
    rescue ::StandardError => e
      # エラーは一旦スキップする
      ::Rails.logger.info("Apple Music ID: #{albums_id}, Error: #{e.message}")
    end

    nil
  end
end
