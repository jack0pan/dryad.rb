require "rails"
require "dryad"

module Dryad
  class Railtie < Rails::Railtie
    initializer "dryad.set_configs" do
      ActiveSupport.on_load(:dryad) do
        environment = ENV["RAILS_ENV"] || "default"
        config = Dryad.load_config[environment]&.deep_symbolize_keys
        Dryad.configuration = Dryad::Configuration.new(config)
      end
    end
  end
  ActiveSupport.run_load_hooks(:dryad, Core)

  module Consul
    class DBConfigObserver < ConfigObserver
      def update_self(config_desc)
        ActiveRecord::Base.configurations = YAML.load(ERB.new(config_desc.payload).result)
        ActiveRecord::Base.establish_connection(Rails.env.to_sym)
      end
    end

    class Railtie < ::Rails::Railtie
      initializer "dryad_consul.set_consul" do
        ActiveSupport.on_load(:dryad_consul) do
          Dryad::Consul.configure_consul(Dryad.configuration)
        end
      end

      initializer "dryad_consul.update_active_record_connection" do
        config.after_initialize do
          db_path = "#{Dryad.configuration.namespace}/#{Dryad.configuration.group}/database.yml"
          observer = ::Dryad::Consul::DBConfigObserver.new
          begin
            db_config = Dryad::Consul::ConfigProvider.instance.load(db_path, observer)
            raise Dryad::Core::ConfigurationNotFound, db_path if db_config.nil?
            ActiveRecord::Base.configurations = YAML.load(ERB.new(db_config.payload).result)
            ActiveRecord::Base.establish_connection(Rails.env.to_sym)
          rescue Dryad::Core::ConfigurationNotFound => e
            raise e
          rescue Exception => e
            Rails.logger.warn e.message
          end
        end
      end

      initializer "dryad_consul.register_services" do
        config.after_initialize do
          name = Dryad.configuration.namespace
          group = Dryad.configuration.group
          service_config = Dryad.configuration.service
          address = service_config[:address] || Socket.ip_address_list.detect{|ai| ai.ipv4_private?}&.ip_address
          schemas = Dryad::Core::Schema.constants.map{|s| Dryad::Core::Schema.const_get(s).to_sym}
          portals = service_config.slice(schemas).map do |k, v|
            check_config = v[:check]
            check = if check_config
              interval = check_config[:interval] || 10
              if check_config[:url]
                http = check_config[:url]
                http = "#{k.to_s}://#{address}:#{port}#{url}" if http.start_with?("/")
                timeout = check_config[:timeout] || 5
                Dryad::Consul::HTTPHealthCheck.new(http, interval, timeout, interval * 10)
              elsif check_config[:grpc_use_tls]
                grpc = "#{address}:#{port}/#{name}"
                Dryad::Consul::GRPCHealthCheck.new(grpc, interval, check_config[:grpc_use_tls], interval * 10)
              else
                Dryad::Consul::TTLHealthCheck.new(interval, interval * 10)
              end
            else
              Dryad::Consul::TTLHealthCheck.new(10, 100)
            end
            Dryad::Core::Portal.new(v.slice(:port, :non_certifications).merge({check: check}))
          end
          service = Dryad::Consul::Service.new({
            name: name,
            group: group,
            address: address,
            portals: portals,
            priority: service_config[:priority] || 0,
            load_balancing: service_config[:load_balancing]
          })
          Dryad::Consul::ServiceRegistry.register(service)
        end
      end
    end
  end
  ActiveSupport.run_load_hooks(:dryad_consul, Consul)

  module Cluster
    class Railtie < Rails::Railtie
      initializer "dryad_cluster.set_config" do
        ActiveSupport.on_load(:dryad_cluster) do
          Dryad::Cluster.configuration = Dryad.configuration
        end
      end
    end
  end
  ActiveSupport.run_load_hooks(:dryad_cluster, Cluster)
end
