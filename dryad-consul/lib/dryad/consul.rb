require "diplomat"
require "dryad/core"
require "dryad/consul/config_observer"
require "dryad/consul/version"
require "dryad/consul/service_registry"
require "dryad/consul/service"
require "dryad/consul/key_value_client"
require "dryad/consul/config_provider"
require "dryad/consul/service_observer"

module Dryad
  module Consul
    class Error < StandardError; end
    class << self
      def configure_consul(configuration)
        consul = configuration.consul
        if consul[:username].nil? || consul[:password].nil?
          url = "http://#{consul[:host]}:#{consul[:port]}"
        else
          require "erb"
          url = "http://#{consul[:username]}:#{ERB::Util.url_encode(consul[:password])}@#{consul[:host]}:#{consul[:port]}"
        end
        ::Diplomat.configure do |config|
          config.url = url
        end
      end

      def build_check(check_config, name, address, port)
        if check_config
          interval = check_config[:interval] || 10
          if check_config[:url]
            http = check_config[:url]
            http = "#{k.to_s}://#{address}:#{port}#{url}" if http.start_with?("/")
            timeout = check_config[:timeout] || 5
            Dryad::Consul::HTTPHealthCheck.new(http, interval, timeout, interval * 10)
          elsif check_config[:grpc_use_tls]
            grpc = "#{address}:#{port}/#{name}"
            Dryad::Consul::GRPCHealthCheck.new(grpc, interval, check_config[:grpc_use_tls], interval * 10)
          else
            Dryad::Consul::TTLHealthCheck.new(interval, interval * 10)
          end
        else
          Dryad::Consul::TTLHealthCheck.new(10, 100)
        end
      end
  
      def build_service(name, group, service_config)
        address = if service_config[:address]
          service_config[:address]
        else
          require 'socket'
          Socket.ip_address_list.detect{|ai| ai.ipv4_private?}&.ip_address
        end
        schemas = Dryad::Core::Schema.constants.map{|s| Dryad::Core::Schema.const_get(s).to_sym}
        portals = service_config.slice(schemas).map do |k, v|
          check = build_check(v[:check], name, address, port)
          Dryad::Core::Portal.new(v.slice(:port, :non_certifications).merge({check: check}))
        end
        Dryad::Consul::Service.new({
          name: name,
          group: group,
          address: address,
          portals: portals,
          priority: service_config[:priority] || 0,
          load_balancing: service_config[:load_balancing]
        })
      end
    end
  end
end
