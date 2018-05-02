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
        origins 'https://tvtd.seamos.co', 'https://seamos.co', 'http://tvtd.seamos.co', 'http://seamos.co'
        resource '*', :headers => :any, :methods => [:get, :post, :put, :patch, :options]
      end
    end
    config.i18n.default_locale = :es
    config.time_zone = 'Bogota'
    Koala.config.api_version = 'v2.0'

    config.action_mailer.preview_path = "#{Rails.root}/views/mailer_previews"
  
    config.action_mailer.delivery_method = :smtp
    
    config.action_mailer.smtp_settings = { :address => "localhost", :port => 1025 }

  end
end
