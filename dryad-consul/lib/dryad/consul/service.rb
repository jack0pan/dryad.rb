module Dryad
  module Consul
    class Service < Dryad::Core::Service
      def to_registers
        portals.map do |portal|
          {
            ID: portal.id,
            Name: Service.full_name(portal.schema, name),
            Address: address,
            Port: portal.port,
            EnableTagOverride: true,
            Tags: tags(portal),
            Checks: checks(portal)
          }
        end
      end

      private
      def tags(portal)
        tags = [
          "type = \"#{type_name}\"",
          "priority = \"#{priority}\"",
          "group = \"#{group}\"",
          "schema = \"#{portal.schema}\"",
          "pattern = \"#{portal.pattern}\""
        ]
        if portal.non_certifications.count > 0
          tags << "non_certifications = \"#{portal.non_certifications.join(",")}\""
        end
        tags.concat(load_balancing.map{|lb| "load_balancing = \"#{lb}\"" })
      end

      def checks(portal)
        if portal.check.nil? || !portal.check.is_a?(Dryad::Consul::HealthCheck)
          []
        else
          [portal.check.attributes]
        end
      end
    end
  end
end
