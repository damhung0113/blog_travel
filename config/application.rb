require_relative "boot"

require "rails/all"

module RubyOpen22BlogTravel
  class Application < Rails::Application
    Bundler.require(*Rails.groups)
    config.load_defaults 5.2
    config.generators.system_tests = nil
  end
end
