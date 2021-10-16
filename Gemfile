# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

# Rails 6
gem 'rails', '~> 6.1.4.1'
# nokogiri
gem 'nokogiri', '~> 1.12.5'
# Maria DB
gem 'mysql2', '>= 0.4.4'
# マルチプロセス
gem 'puma', '~> 5.5.2'
# Rails 起動高速化
gem 'bootsnap', '>= 1.4.2', require: false
# GraphQL
gem 'graphql', '~> 1.12.16'
# HTTP Client
gem 'faraday', '~> 1.8.0'
# HTTP Client faraday_middleware
gem 'faraday_middleware', '~> 1.1.0'
# 暗号化
gem 'bcrypt', '~> 3.1.16'
# 暗号化 jwt
gem 'jwt', '~> 2.3.0'
# HTTP メソッド許可
gem 'rack-cors', '~> 1.1.1'
# DoS攻撃対策
gem 'rack-attack', '~> 6.5.0'
# 画像操作
gem 'mini_magick', '~> 4.11.0'
# GraphQL 実行画面
gem 'graphiql-rails', '~> 1.8.0'
# Twitter 投稿
gem 'twitter', '~> 7.0.0'
# Google Analytics
gem 'google-apis-analyticsreporting_v4', '~> 0.5.0'

group :development, :test do
  # ブレイクポイント
  gem 'pry-byebug', '~> 3.9.0'
  # pry-doc
  gem 'pry-doc', '~> 1.2.0'
  # 型検証
  gem 'rbs_rails', '~> 0.9.0'
  # linter
  gem 'rubocop', '~> 1.22.1', require: false
end

group :development do
  # ファイル更新監視
  gem 'listen', '>= 3.0.5', '< 3.2'
  # 実行高速化
  gem 'spring', '~> 2.1.1'
end
