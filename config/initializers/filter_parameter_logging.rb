# ログ表示時に password と付くパラメータを非表示にする
Rails.application.config.filter_parameters += [:password]
