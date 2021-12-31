# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

# Rails
gem 'rails', github: 'rails/rails', branch: '7-0-stable'
# DB
gem 'mysql2', '~> 0.5'
# App server
gem 'puma', '~> 5.0'
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

group :development, :test do
  # Ruby debug
  gem 'debug', '~> 1.3.4'
  # 型検証
  gem 'rbs_rails', '~> 0.9.0', require: false
end

# タイムゾーン
gem 'tzinfo-data', '~> 1.2021.4', platforms: %i[mingw mswin x64_mingw jruby]
