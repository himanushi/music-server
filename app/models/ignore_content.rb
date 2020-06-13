# 更新などで強制的に対象外にするコンテンツ
# status が active な場合でも除外する
class IgnoreContent < ApplicationRecord
  table_id :igc
end
