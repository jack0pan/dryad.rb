require "diplomat"
require "dryad"
require "dryad/consul/version"
require "dryad/consul/service_client"
require "dryad/consul/service_registry"
require "dryad/consul/service"
require "dryad/consul/key_value_client"
require "dryad/consul/config_provider"

module Dryad
  module Consul
    class Error < StandardError; end

    ::Diplomat.configure do |config|
      config.url = "http://#{Dryad.configuration.consul[:host]}:#{Dryad.configuration.consul[:port]}"
      config.options = { headers: { "X-Consul-Token" => Dryad.configuration.consul[:token] } } if Dryad.configuration.consul[:token]
    end
  end
end
