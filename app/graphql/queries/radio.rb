module Queries
  class Radio < BaseQuery
    description "プレイリスト取得"

    type RadioType, null: true

    argument :id,  TTID, required: true, description: "ID"

    def query(id:)
      ::Radio.find_by(id: id)
    end
  end
end
