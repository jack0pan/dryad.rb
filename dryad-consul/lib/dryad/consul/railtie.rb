require "rails"
require "dryad"

module Dryad
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
    end
  end
  ActiveSupport.run_load_hooks(:dryad_consul, Consul)
end
