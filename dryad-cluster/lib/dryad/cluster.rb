require "dryad"
require "dryad/cluster/version"

module Dryad
  module Cluster
    class Error < StandardError; end

    class << self
      REGISTRY = Object.const_get(Dryad.configuration.registry)

      def round_robin(schema, service_name)
        groups = ['_global_', Dryad.configuration.group]
        REGISTRY.service_instances(service_name, schema, groups).first
      end
    end
  end
end
