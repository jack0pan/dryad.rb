module Dryad
  module Consul
    class Railtie < Rails::Railtie
      initializer "dryad_consul.set_consul" do
        ::Diplomat.configure do |config|
          config.url = "http://#{Dryad.configuration.consul[:host]}:#{Dryad.configuration.consul[:port]}"
          config.options = { headers: { "X-Consul-Token" => Dryad.configuration.consul[:token] } } if Dryad.configuration.consul[:token]
        end
      end
    end
  end
  ActiveSupport.run_load_hooks(:dryad_consul, Consul)
end
