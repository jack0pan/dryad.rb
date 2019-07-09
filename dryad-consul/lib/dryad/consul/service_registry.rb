require 'singleton'
require 'concurrent'

module Dryad
  module Consul
    class ServiceRegistry
      include Singleton
      WATCHER_EXECUTION_INTERVAL = 5 * 60

      def initialize
        @timers = {}
      end

      def register(service)
        service.to_registers.each do |register|
          ::Diplomat::Service.register(register)
        end
      end

      def deregister(service)
        service.portals.each do |portal|
          ::Diplomat::Service.deregister(portal.id)
        end
      end

      def service_instances(name, schema, groups, observer = nil)
        add_observer(observer, name, schema, groups) unless observer.nil?
        _service_instances(name, schema, groups)
      end

      private
      def _service_instances(name, schema, groups)
        service_name = Dryad::Core::Service.full_name(schema, name)
        all_services = ::Diplomat::Health.service(service_name)
        service_instances = filter_services(all_services, groups)
        service_instances.map do |service|
          Dryad::Core::ServiceInstance.new(
            name: name,
            schema: schema,
            address: service["Address"],
            port: service["Port"]
          )
        end
      end

      def filter_services(all_services, groups)
        service_hashs = []
        all_services.each do |service|
          service_hash = service.Service
          if !service_hash["Meta"].nil? && service_hash["Meta"].has_key?("group") &&
            groups.include?(service_hash["Meta"]["group"])
            service_instances << service_hash
          else
            groups.each do |group|
              if service_hash["Tags"].include?("group = \"#{group}\"")
                service_hashs << service_hash
                break
              end
            end
          end
        end
        service_hashs
      end

      def add_observer(observer, name, schema, groups)
        if observer && observer.is_a?(Dryad::Consul::ServiceObserver)
          service_name = Dryad::Core::Service.full_name(schema, name)
          if @timers.has_key?(service_name)
            @timers[service_name].add_observer(observer)
          else
            timer = Concurrent::TimerTask.new(execution_interval: WATCHER_EXECUTION_INTERVAL) do
              _service_instances(service_name, groups)
            end
            timer.add_observer(observer)
            timer.execute
            @timers[service_name] = timer
          end
        end
      end
    end
  end
end
