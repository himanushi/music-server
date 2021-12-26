# frozen_string_literal: true

module TTID
  REGEXP = /\A([a-z]{3})([0-9a-f]{11})([0-9a-f]{2})\z/
  public_constant :REGEXP

  module InstanceMethods
    def identify
      builded_id = build_id
      raise(::StandardError, "TTID の正規表現とマッチしない(#{builded_id})") unless builded_id.match?(::TTID::REGEXP)

      self.id = builded_id
    end

    def unix_timestamp
      # IDの採番はDBの時間基準とする
      ::ActiveRecord::Base.connection.select_value('SELECT TRUNCATE(UNIX_TIMESTAMP(NOW(3)) * 1000, 0)')
    end

    def table_id
      raise(::NotImplementedError)
    end

    def hex_time
      unix_timestamp.to_s(16)
    end

    def build_id
      "#{table_id}#{hex_time}#{::SecureRandom.hex(1)}"
    end
  end
end
