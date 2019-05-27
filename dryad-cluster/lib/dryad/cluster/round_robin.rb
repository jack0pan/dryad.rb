module Dryad
  module Cluster
    class RoundRobin
      def initialize
        @index = Concurrent::AtomicFixnum.new
        @services = Concurrent::AtomicReference.new
      end

      def set_services(instances)
        @services.set(instances)
      end

      def service
        instances = @services.get()
        if instances.nil? || instances.empty?
          raise Dryad::Cluster::NoServicesError, "Round robin nodes are empty."
        end
        instances[@index.increment % instances.size]
      end
    end
  end
end
