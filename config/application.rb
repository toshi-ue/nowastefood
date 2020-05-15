require_relative 'boot'

# require "rails"
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Webapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # locale
    config.i18n.available_locales = [ :en, :ja ]
    # default locale
    config.i18n.default_locale = :ja

    config.time_zone = 'Tokyo'
    # change db time_zone
    config.active_record.default_timezone = :local

    # Don't generate system test files.
    config.generators.system_tests = nil

    # RSpec generator setting
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: false,
                       request_specs: true,
                       system_specs: true
    end
  end
end
