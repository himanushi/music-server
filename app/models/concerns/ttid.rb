# TTID
# Table id and hex Timestamp and hex ID
module TTID
  extend ActiveSupport::Concern

  REGEXP = /\A([a-z]{4})([0-9a-f]{14})([0-9a-f]{6})\z/

  class << self
    def to_hash(id)
      return nil unless REGEXP =~ id
      {
        table_id:      Regexp.last_match[1],
        hex_timestamp: Regexp.last_match[2],
        hex_id:        Regexp.last_match[3],
      }
    end

    def decode(id)
      return nil unless result = to_hash(id)
      {
        model:     table_info[result[:table_id]],
        timestamp: to_timestamp(result[:hex_timestamp]),
        hex_id:    result[:hex_id],
      }
    end

    def to_timestamp(hex_timestamp)
      Time.at(hex_timestamp.to_i(16).to_f / 1000000)
    end

    def table_info
      @_table_info ||= {}
    end

    def add_table_info(info)
      if table_info.has_key?(key = info.keys.first)
        raise StandardError, "テーブルIDが重複しました。別のテーブルIDに変更してください。[#{ key }]"
      end
      @_table_info = table_info.merge(info)
    end

    def unix_timestamp_usec6
      # IDの採番はDBの時間基準とする
      # 複数インスタンスを立ち上げた場合にアプリ基準の時間にすると不整合が発生する可能性があるため
      # TODO: 性能に問題がある場合は DB で関数を作成し ID を生成すること
      ActiveRecord::Base.connection.select_value("SELECT CAST((UNIX_TIMESTAMP(NOW(6)) * 1000000) AS INTEGER)")
    end
  end

  included do
    before_create :identify

    def identify
      self.id ||= build_id
    end

    def build_id
      self.class.build_id
    end
  end

  class_methods do
    def table_id(_table_id = nil)
      return @table_id.dup if @table_id.present?

      raise NotImplementedError, "テーブルIDを必ず実装すること" unless _table_id.present?
      raise StandardError, "テーブルIDは /[a-z]{4}/ にすること[#{_table_id}]" unless /[a-z]{4}/.match?(_table_id)

      _table_id = _table_id.to_s

      @table_id ||= begin
        TTID.add_table_info({ _table_id => self })
        _table_id
      end
    end

    def hex_time
      # 4253-05-31 22:20:37 まで使用可能
      TTID.unix_timestamp_usec6.to_s(16).rjust(14, "0")
    end

    def build_id
      table_id << hex_time << SecureRandom.hex(3)
    end
  end
end
