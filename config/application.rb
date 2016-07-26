require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BankRor
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.middleware.delete ::Rack::ETag
    config.middleware.delete ::Rack::Sendfile
    config.middleware.delete ::Rack::ConditionalGet
    config.middleware.delete ::ActionDispatch::Static
    config.middleware.delete ::ActionDispatch::Reloader
    config.middleware.delete ::ActionDispatch::Cookies
    config.middleware.delete ::ActionDispatch::Session::CacheStore
    config.middleware.delete ::ActionDispatch::Session::CookieStore
  end
end
