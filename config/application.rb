require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Server
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.autoload_paths += %W(#{config.root}/lib)

    config.api_only = true

    # 悪意のあるリクエスト対策
    config.middleware.use Rack::Attack

    # I18n
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '**', '*.{rb,yml}').to_s]

    # React Apollo 対応
    # https://mattboldt.com/2019/06/23/rails-graphql-react-apollo-part-two/
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        if Rails.env.production?
          origins [ENV['PRODUCTION_APP_URL'], /capacitor:\/\/localhost/]
          resource '*', headers: :any, methods: [:get, :post, :options], credentials: true
        else
          origins ["http://localhost:3000", "http://localhost:8080", "http://localhost:50000", /capacitor:\/\/localhost/]
          resource '*', headers: :any, methods: [:get, :post, :options], credentials: true
        end
      end
    end
  end
end
