# frozen_string_literal: true

# ログ出力すべきでないものはマスク
::Rails.application.config.filter_parameters += %i[password passw secret token _key crypt salt certificate otp ssn]
