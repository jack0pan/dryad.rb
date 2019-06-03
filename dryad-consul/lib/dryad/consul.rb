require "diplomat"
require "dryad"
require "dryad/consul/railtie" if defined?(Rails)
require "dryad/consul/version"
require "dryad/consul/service_client"
require "dryad/consul/service_registry"
require "dryad/consul/service"
require "dryad/consul/key_value_client"
require "dryad/consul/config_provider"

module Dryad
  module Consul
    class Error < StandardError; end
  end
end
