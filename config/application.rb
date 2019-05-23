require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Seamos
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'https://seamosbuenaventura.co', 'http://seamosbuenaventura.co'
        resource '*', :headers => :any, :methods => [:get, :post, :put, :patch, :options]
      end
    end
    config.i18n.default_locale = :es
    config.time_zone = 'Bogota'
    Koala.config.api_version = 'v2.0'

    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'application.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end
  end
end