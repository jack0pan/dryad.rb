require "diplomat"
require "dryad/core"
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
    class << self
      def configure_consul(configuration)
        ::Diplomat.configure do |config|
          config.url = "http://#{configuration.consul[:host]}:#{configuration.consul[:port]}"
          config.options = { headers: { "X-Consul-Token" => configuration.consul[:token] } } if configuration.consul[:token]
        end
      end
    end
  end
end
