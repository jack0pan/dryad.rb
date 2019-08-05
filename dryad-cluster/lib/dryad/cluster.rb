require 'concurrent'
require "dryad/core"
require "dryad/consul"
require "dryad/cluster/version"
require "dryad/cluster/round_robin"
require "dryad/cluster/service_observer"

module Dryad
  module Cluster
    class Error < StandardError; end
    class NoServicesError < Error; end

    class << self
      attr_accessor :configuration
      CLUSTERS = {}

      def round_robin(schema, service_name)
        groups = ['_global_', @configuration.group]
        full_name = Dryad::Core::Service.full_name(schema, service_name)
        if CLUSTERS[full_name].nil?
          CLUSTERS[full_name] = Dryad::Cluster::RoundRobin.new
          observer = Dryad::Cluster::ServiceObserver.new(CLUSTERS[full_name])
          CLUSTERS[full_name].set_services(sorted_instances(service_name, schema, groups, observer))
        end
        begin
          retries ||= 0
          CLUSTERS[full_name].service
        rescue Dryad::Cluster::NoServicesError
          CLUSTERS[full_name].set_services(sorted_instances(service_name, schema, groups))
          retry if (retries += 1) < 2
        end
      end

      def sorted_instances(service_name, schema, groups, observer)
        sis = if @configuration.cluster.nil?
                registry = Object.const_get(@configuration.registry).instance
                registry.service_instances(service_name, schema, groups, observer)
              else
                (@configuration.cluster[service_name.to_sym] || []).map do |s|
                  Dryad::Core::ServiceInstance.new(
                    name: service_name,
                    schema: schema,
                    address: s[:address],
                    port: s[:port]
                  )
                end
              end
        sis.sort {|a, b| "#{a.address}:#{a.port}" <=> "#{b.address}:#{b.port}"}
      end
    end
  end
end
