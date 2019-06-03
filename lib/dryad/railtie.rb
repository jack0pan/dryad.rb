require "dryad"
require "rails"

module Dryad
  class Railtie < Rails::Railtie
    initializer "dryad.set_configs" do
      ActiveSupport.on_load(:dryad) do
        environment = ENV["RAILS_ENV"] || "default"
        Dryad.configure { Dryad.load_config[environment].deep_symbolize_keys }
      end
    end
  end
  ActiveSupport.run_load_hooks(:dryad, Core)
end
