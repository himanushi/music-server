source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

# Rails 6
gem 'rails', '~> 6.1.4.1'
gem "nokogiri", ">= 1.12.5"
# Maria DB
gem 'mysql2', '>= 0.4.4'
# マルチプロセス
gem 'puma', '~> 5.5.0'
# Rails 起動高速化
gem 'bootsnap', '>= 1.4.2', require: false
# GraphQL
gem 'graphql'
# GraphQL N+1 対策
gem 'graphql-batch'
# HTTP Client
gem 'faraday'
gem 'faraday_middleware'
# 暗号化
gem 'bcrypt'
gem 'jwt'
# HTTP メソッド許可
gem 'rack-cors'
# DoS攻撃対策
gem 'rack-attack'
# 画像操作
gem "mini_magick"
# GraphQL 実行画面
gem 'graphiql-rails'
# Twitter 投稿
gem 'twitter'
# Google Analytics
gem 'google-apis-analyticsreporting_v4'

group :development, :test do
  # ブレイクポイント
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
  # 型検証
  gem "rbs"
  gem 'rbs_rails'
  gem "steep"
  gem "typeprof"
end

group :development do
  # ファイル更新監視
  gem 'listen', '>= 3.0.5', '< 3.2'
  # テスト実行高速化
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
