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
          all_services = ServiceClient.get(Service.full_name(schema, name), :all)
          services = []
          all_services.each do |service|
            groups.each do |group|
              services << service if service.ServiceTags.include?("group = \"#{group}\"")
            end
          end
          services.map do |service|
            Dryad::Core::ServiceInstance.new(
              name: name,
              schema: schema,
              address: service.ServiceAddress,
              port: service.ServicePort
            )
          end
        end
      end
    end
  end
end
