# frozen_string_literal: true

# ログ出力したくなときに使う
::Rails.backtrace_cleaner.remove_silencers! if ::ENV['BACKTRACE']
