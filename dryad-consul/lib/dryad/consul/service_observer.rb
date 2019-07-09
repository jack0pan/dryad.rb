module Dryad
  module Consul
    class ServiceObserver < ::Dryad::Core::Observer
      def update(time, service_instances, exception)
        if exception
          puts "(#{time}) [#{self.class.to_s}] #{exception.message}"
        elsif service_instances
          update_self(service_instances)
        end
      end

      def update_self(service_instances)
        raise "Implement this method"
      end
    end
  end
end
