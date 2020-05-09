module Types
  module Enums
    class StatusEnum < GraphQL::Schema::Enum
      value "PENDING", value: "pending", description: "保留 : デフォルトの検索結果に表示されない"
      value "ACTIVE",  value: "active", description: "有効 : 通常検索結果に表示される"
      value "IGNORE",  value: "ignore", description: "除外 : 検索結果から除外される。最新情報などを取得する際などでも除外される"
    end
  end
end
