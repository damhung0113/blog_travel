require_relative "boot"

require "rails/all"

module RubyOpen22BlogTravel
  class Application < Rails::Application
    Bundler.require(*Rails.groups)
    config.load_defaults 5.2
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]
    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :en
    config.generators.system_tests = nil
  end
end
