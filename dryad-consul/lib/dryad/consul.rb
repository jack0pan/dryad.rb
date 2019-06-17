require "diplomat"
require "dryad/core"
require "dryad/consul/config_observer"
require "dryad/consul/railtie" if defined?(Rails)
require "dryad/consul/version"
require "dryad/consul/service_registry"
require "dryad/consul/service"
require "dryad/consul/key_value_client"
require "dryad/consul/config_provider"

require "erb"

module Dryad
  module Consul
    class Error < StandardError; end
    class << self
      def configure_consul(configuration)
        consul = configuration.consul
        if consul[:username].nil? || consul[:password].nil?
          url = "http://#{consul[:host]}:#{consul[:port]}"
        else
          url = "http://#{consul[:username]}:#{ERB::Util.url_encode(consul[:password])}@#{consul[:host]}:#{consul[:port]}"
        end
        ::Diplomat.configure do |config|
          config.url = url
        end
      end
    end
  end
end
