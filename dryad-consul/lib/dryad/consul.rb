require "diplomat"
require "dryad"
require "dryad/consul/version"
require "dryad/consul/service_client"
require "dryad/consul/service_registry"
require "dryad/consul/service"

module Dryad
  module Consul
    class Error < StandardError; end

    ::Diplomat.configure do |config|
      config.url = "http://#{Dryad.configuration.consul[:host]}:#{Dryad.configuration.consul[:port]}"
    end
  end
end
