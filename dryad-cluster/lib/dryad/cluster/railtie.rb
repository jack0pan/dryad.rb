require "rails"
require "dryad"

module Dryad
  module Cluster
    class Railtie < class Rails::Railtie
      initializer "dryad_cluster.set_config" do
        ActiveSupport.on_load(:dryad_cluster) do
          Dryad::Cluster.configuration = Dryad.configuration
        end
      end
    end
  end
  ActiveSupport.run_load_hooks(:dryad_cluster, Cluster)
end
