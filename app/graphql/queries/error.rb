module Queries
  class Error < BaseQuery
    description "必ずエラーを発生させる。セッションテストなどで使用"

    type String, null: false

    def query
      raise StandardError, "エラー"
    end
  end
end
