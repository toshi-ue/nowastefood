require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

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
  end
end
