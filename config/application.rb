# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
# require "active_job/railtie"
require 'active_record/railtie'
# require "active_storage/engine"
require 'action_controller/railtie'
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
# require 'action_view/railtie'
# require 'action_cable/engine'
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
::Bundler.require(*::Rails.groups)

module MusicServer
  class Application < ::Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults(6.1)
    config.autoload_paths += %W[#{config.root}/lib]

    config.i18n.default_locale = :ja

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil

    # CSRF 無効
    config.action_controller.allow_forgery_protection = false

    config.after_initialize do
      ::Dir[::Rails.root.join('config', 'after_initializers', '*.rb')].each { |file| load file }
    end

    # Apollo Client 対応
    # https://mattboldt.com/2019/06/23/rails-graphql-react-apollo-part-two/
    config.middleware.insert_before(0, ::Rack::Cors) do
      allow do
        if ::Rails.env.production?
          origins [*::ENV['PRODUCTION_APP_URL'].split(','), %r{capacitor://localhost}]
        else
          origins [%r{http://localhost}, %r{capacitor://localhost}]
        end
        resource '*', headers: :any, methods: %i[get post options], credentials: true
      end
    end
  end
end
