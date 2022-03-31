# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

# Rails
gem 'rails', '~> 7.0.2.3'
# DB
gem 'mysql2', '~> 0.5'
# App server
gem 'puma', '~> 5.6.4'
# HTTP メソッド許可
gem 'rack-cors', '~> 1.1.1'
# GraphQL
gem 'graphql', '~> 1.12.19'
# GraphQL GUI
gem 'graphiql-rails', '~> 1.8.0'
# 暗号化 jwt
gem 'jwt', '~> 2.3.0'
# 暗号化 bcrypt
gem 'bcrypt', '~> 3.1.16'
# Twitter 投稿
gem 'twitter', '~> 7.0.0'
# HTTP Client
gem 'faraday', '~> 2.2.0'
# Google Analytics
gem 'google-apis-analyticsreporting_v4', '~> 0.7.0'
# Google BigQuery
gem 'google-cloud-bigquery', '~> 1.38.1'

group :development, :test do
  # Ruby debug
  gem 'debug', '~> 1.3.4'
  # 型検証
  gem 'rbs_rails', '~> 0.11.0', require: false
end

# タイムゾーン
gem 'tzinfo-data', '~> 1.2021.4', platforms: %i[mingw mswin x64_mingw jruby]
