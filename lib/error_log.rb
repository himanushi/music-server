class ErrorLog
  class << self
    # エラー発生箇所の取得
    def path(frame_no)
      raise StandardError
    rescue => e
      e.backtrace[frame_no].gsub(/:in.*/, "")
    end
  end
end
