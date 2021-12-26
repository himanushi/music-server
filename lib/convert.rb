# frozen_string_literal: true

class Convert
  class << self
    def to_name(name)
      converted_name =
        name.
        # 英数を全角から半角へ変換
        tr('０-９ａ-ｚＡ-Ｚ', '0-9a-zA-Z').
        # カタカナを半角から全角へ変換
        sub(/[\uFF61-\uFF9F]+/) { |str| str.unicode_normalize(:nfkc) }.
        # 半角全角スペースを削除して英語名の場合は名前ごとに区切ってキャメルケースにして半角スペースを追加する
        split(/\p{blank}/).map { |n| n.camelize }
            .join(' ').gsub(/([^A-Za-z\s])\s([^A-Za-z\s])/, '\1\2')
      raise(::StandardError, '空文字のアーティスト名になっている') unless converted_name.present?

      converted_name
    end

    # api 経由で取得した日付をよしなに日時へ変換
    def to_time(date_str)
      date = date_str.dup
      date.gsub!(%r{/}, '-')

      case date
      when /\A[0-9]{4}\z/
        date << '-01-01'
      when /\A[0-9]{4}-[0-9]{1,2}\z/
        date << '-01'
      else
        date
      end.in_time_zone
    end
  end
end
