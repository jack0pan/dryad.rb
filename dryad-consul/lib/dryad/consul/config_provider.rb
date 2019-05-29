module Dryad
  module Consul
    class ConfigProvider < Dryad::Core::ConfigProvider
      class << self
        def load(path, listener = nil)
          config = Dryad::Consul::KeyValueClient.get(path)
          if config.nil?
            raise Dryad::Core::ConfigurationNotFound, path
          else
            Dryad::Core::ConfigDesc.new(path, config.Value, config.ModifyIndex)
          end
        end
      end
    end
  end
end
