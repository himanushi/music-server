# TTID
# Table id, hex Timestamp, ID
module TTID
  extend ActiveSupport::Concern

  REGEXP = /\A([a-z]{3})([0-9a-f]{11})([0-9a-f]{2})\z/

  class << self
    def to_hash(id)
      return nil unless REGEXP =~ (id)
      {
        table_id:      $1,
        hex_timestamp: $2,
        hex_id:        $3,
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
      Time.at(hex_timestamp.to_i(16).to_f / 1000)
    end

    def table_info
      @_table_info ||= {}
    end

    def add_table_info(info)
      key = info.keys.first || ""
      if table_info.has_key?(key)
        raise StandardError, "テーブルIDが重複しました。別のテーブルIDに変更してください。[#{ key }]"
      end
      @_table_info = table_info.merge(info)
    end

    def unix_timestamp_usec3
      # IDの採番はDBの時間基準とする
      # 複数インスタンスを立ち上げた場合にアプリ基準の時間にすると不整合が発生する可能性があるため
      # TODO: 性能に問題がある場合は DB で関数を作成し ID を生成すること
      # memo: SELECT LOWER(CONCAT(HEX(CAST((UNIX_TIMESTAMP(NOW(3)) * 1000) AS INTEGER)), SUBSTRING(MD5(RAND()), 1, 4)))
      ActiveRecord::Base.connection.select_value("SELECT CAST((UNIX_TIMESTAMP(NOW(3)) * 1000) AS INTEGER)")
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

  module ClassMethods
    # 検証元のクラスと検証したいID
    def validate_ids!(ids)
      ids.each do |id|
        decoded_hash = TTID.decode(id)
        unless decoded_hash.present? && decoded_hash[:model] == self
          raise StandardError, "TTIDが不一致(#{ErrorLog.path(4)})"
        end
      end
      true
    end

    def table_id(_table_id = nil)
      return @table_id.dup if @table_id.present?

      raise NotImplementedError, "テーブルIDを必ず実装すること" unless _table_id.present?
      raise StandardError, "テーブルIDは /[a-z]{3}/ にすること[#{_table_id}]" unless /[a-z]{3}/.match?(_table_id)

      _table_id = _table_id.to_s

      @table_id ||= begin
        TTID.add_table_info({ _table_id => self })
        _table_id
      end
    end

    def hex_time
      TTID.unix_timestamp_usec3.to_s(16)
    end

    def build_id
      table_id << hex_time << SecureRandom.hex(1)
    end
  end
end
