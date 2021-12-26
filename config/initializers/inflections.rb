# frozen_string_literal: true

# 全て大文字小文字クラスが作成できる
::ActiveSupport::Inflector.inflections do |inflect|
  inflect.acronym('TTID')
end
