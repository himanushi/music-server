# rbs とか rbi はまだ確定ではないので暫定で型チェックする(安心したい)。
# 実行時にエラーで知らせる。遅くなっても個人開発なので安心を優先する。
class TypeValidator
  require "minitest"
  include Minitest::Assertions

  attr_accessor :assertions, :failure

  def initialize
    self.assertions = 0
    self.failure = nil
  end

  class << self
    def arg_type(type, arg)
      new.assert_instance_of(
        type, arg,
        "引数が指定したクラスと不一致[ 想定: #{type}, 実体: #{arg.class}(#{arg}) ]"
      )
    end
  end
end
