# TTID
# Timestamp and Table Hex ID
module TTID
  extend ActiveSupport::Concern

  REGEXP = /\A([a-z0-9]{10})([A-Za-z0-9_-]{4})([A-Za-z0-9_-]{6})\z/

  class DuplicateDefinedTableIdError < StandardError; end

  class << self
    def to_hash(id)
      return nil unless REGEXP =~ id
      {
        hex_timestamp: Regexp.last_match[1],
        table_id:      Regexp.last_match[2],
        hex_id:        Regexp.last_match[3],
      }
    end

    def decode(id)
      return nil unless result = to_hash(id)
      {
        timestamp: to_timestamp(result[:hex_timestamp]),
        model:     table_info[result[:table_id]],
        hex_id:    result[:hex_id],
      }
    end

    def to_timestamp(hex_timestamp)
      Time.at(hex_timestamp.to_i(36).to_f / 100000)
    end

    def table_info
      @_table_info ||= {}
    end

    def add_table_info(info)
      if table_info.has_key?(info.keys.first)
        raise DuplicateDefinedTableIdError, "テーブル Hex が重複しました。別のテーブルIDに変更してください。"
      end
      @_table_info = table_info.merge(info)
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
      if @table_id.present? && _table_id.present?
        raise DuplicateDefinedTableIdError, "テーブルIDは重複して宣言できません"
      elsif @table_id.nil? && _table_id.nil?
        raise NotImplementedError, "テーブルIDを必ず実装し絶対に変更しないこと"
      end

      @table_id ||= begin
        id = _table_id.to_s
        TTID.add_table_info({ "#{crypt_table_id(id)}" => self })
        id
      end
    end

    def crypt_table_id(id = nil)
      @crypt_table_id ||= Base64.urlsafe_encode64(id || table_id)[..3]
    end

    def hex_time
      # 3128-08-04 11:40:00 まで使用可能
      (Time.now.to_f * 100000).to_i.to_s(36)
    end

    def build_id
      hex_time << crypt_table_id << SecureRandom.urlsafe_base64(4, false)
    end
  end
end
