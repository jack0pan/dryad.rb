module Dryad
  module Cluster
    class ServiceObserver < ::Dryad::Consul::ServiceObserver
      def initialize(round_robin)
        @round_robin = round_robin
      end

      def update_self(service_instances)
        sis = service_instances.sort {|a, b| "#{a.address}:#{a.port}" <=> "#{b.address}:#{b.port}"}
        @round_robin.set_services(sis)
      end
    end
  end
end