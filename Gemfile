source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Rails 6.0
gem 'rails', '~> 6.0.2.1'
# Maria DB
gem 'mysql2', '>= 0.4.4'
# マルチプロセス
gem 'puma', '~> 3.11'
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
gem 'jwt'
# HTTP メソッド許可
gem 'rack-cors'

group :development, :test do
  # ブレイクポイント
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
end

group :development do
  # GraphQL 実行画面
  gem 'graphiql-rails'
  # ファイル更新監視
  gem 'listen', '>= 3.0.5', '< 3.2'
  # テスト実行高速化
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# タイムゾーン
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
