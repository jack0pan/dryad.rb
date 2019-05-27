require 'concurrent'
require "dryad"
require "dryad/cluster/version"
require "dryad/cluster/round_robin"

module Dryad
  module Cluster
    class Error < StandardError; end
    class NoServicesError < Error; end

    class << self
      REGISTRY = Object.const_get(Dryad.configuration.registry)
      CLUSTERS = {}

      def round_robin(schema, service_name)
        groups = ['_global_', Dryad.configuration.group]
        full_name = Dryad::Core::Service.full_name(schema, service_name)
        if CLUSTERS[full_name].nil?
          CLUSTERS[full_name] = Dryad::Cluster::RoundRobin.new
          CLUSTERS[full_name].set_services(sorted_instances(service_name, schema, groups))
        end
        begin
          retries ||= 0
          CLUSTERS[full_name].service
        rescue Dryad::Cluster::NoServicesError
          CLUSTERS[full_name].set_services(sorted_instances(service_name, schema, groups))
          retry if (retries += 1) < 2
        end
      end

      def sorted_instances(service_name, schema, groups)
        sis = REGISTRY.service_instances(service_name, schema, groups)
        sis.sort {|a, b| "#{a.address}:#{a.port}" <=> "#{b.address}:#{b.port}"}
      end
    end
  end
end
