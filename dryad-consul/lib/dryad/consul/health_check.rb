module Dryad
  module Consul
    class HealthCheck
      attr_accessor :deregister_critial_service_after

      def initialize(duration)
        @deregister_critial_service_after = duration
      end

      def attributes
        self.instance_variables.map do |attribute|
          key = attribute.to_s.gsub('@', '')
          [key, self.instance_variable_get(attribute)]
        end.to_h
      end
    end

    class TTLHealthCheck < HealthCheck
      attr_accessor :ttl

      def initialize(ttl, deregister_critial_service_after)
        super(deregister_critial_service_after)
        @ttl = ttl
      end
    end

    class HTTPHealthCheck < HealthCheck
      attr_accessor :http, :interval, :timeout

      def initialize(http, interval, timeout, deregister_critial_service_after)
        super(deregister_critial_service_after)
        @http = http
        @interval = interval
        @timeout = timeout
      end
    end

    class GRPCHealthCheck < HealthCheck
      attr_accessor :grpc, :interval, :grpc_use_tls

      def initialize(grpc, interval, grpc_use_tls, deregister_critial_service_after)
        super(deregister_critial_service_after)
        @grpc = grpc
        @interval = interval
        @grpc_use_tls = grpc_use_tls
      end
    end
  end
end
