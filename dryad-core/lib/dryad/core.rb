require "dryad/core/version"
require "dryad/core/service_instance"
require "dryad/core/service"
require "dryad/core/portal"
require "dryad/core/load_balancing"
require "dryad/core/schema"
require "dryad/core/config_desc"
require "dryad/core/config_provider"

module Dryad
  module Core
    class Error < StandardError; end
    class ConfigurationNotFound < Error; end
  end
end
