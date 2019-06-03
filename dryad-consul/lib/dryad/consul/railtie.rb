require "rails"

module Dryad
  module Consul
    class Railtie < Rails::Railtie
      initializer "dryad_consul.set_consul" do
        ::Diplomat.configure do |config|
          config.url = "http://#{Dryad.configuration.consul[:host]}:#{Dryad.configuration.consul[:port]}"
          config.options = { headers: { "X-Consul-Token" => Dryad.configuration.consul[:token] } } if Dryad.configuration.consul[:token]
        end
      end

      initializer "dryad_consul.update_active_record_connection" do
        config.after_initialize do
          db_path = "#{Dryad.configuration.namespace}/#{Dryad.configuration.group}/database.yml"
          db_config = Dryad::Consul::ConfigProvider.load(db_path)
          ActiveRecord::Base.configurations = YAML.load(ERB.new(db_config.payload).result)
          ActiveRecord::Base.establish_connection(Rails.env.to_sym)
        rescue Dryad::Core::ConfigurationNotFound => e
          raise e
        rescue e
          puts e.message
        end
      end
    end
  end
  ActiveSupport.run_load_hooks(:dryad_consul, Consul)
end
