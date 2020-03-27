class DateUtil
  class << self
    # api 経由で取得した日付をよしなに日時へ変換
    def data_to_datetime(date)
      _date = date.dup.to_s
      _date.gsub!(/\//, "-")

      case _date
      when /\A[0-9]{4}\z/
        _date << "-01-01"
      when /\A[0-9]{4}-[0-9]{1,2}\z/
        _date << "-01"
      else
        _date
      end.to_datetime
    end
  end
end
