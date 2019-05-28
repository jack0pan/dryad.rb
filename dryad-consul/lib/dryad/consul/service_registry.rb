module Dryad
  module Consul
    class ServiceRegistry
      class << self
        def register(service)
          service.to_registers.each do |register|
            ServiceClient.register(register)
          end
        end

        def deregister(service)
          service.portals.each do |portal|
            ServiceClient.deregister(portal.id)
          end
        end

        def service_instances(name, schema, groups)
          all_services = ::Diplomat::Health.service(Dryad::Core::Service.full_name(schema, name))
          service_instances = []
          all_services.each do |service|
            service_hash = service.Service
            if !service_hash["Meta"].nil? && service_hash["Meta"].has_key?("group") &&
              groups.include?(service_hash["Meta"]["group"])
              service_instances << service_hash
            else
              groups.each do |group|
                if service_hash["Tags"].include?("group = \"#{group}\"")
                  service_instances << service_hash
                  break
                end
              end
            end
          end
          service_instances.map do |service|
            Dryad::Core::ServiceInstance.new(
              name: name,
              schema: schema,
              address: service["Address"],
              port: service["Port"]
            )
          end
        end
      end
    end
  end
end
