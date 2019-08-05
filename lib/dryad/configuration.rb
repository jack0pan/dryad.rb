module Dryad
  class Configuration
    attr_accessor :consul, :namespace, :group, :registry, :provider, :service, :cluster

    DEFAULT_OPTIONS = {
      consul: {
        host: '127.0.0.1',
        port: 8500
      },
      service: {}
    }

    def initialize(opts = {})
      opts = DEFAULT_OPTIONS.merge(opts)
      @consul = opts[:consul]
      @namespace = opts[:namespace]
      @group = opts[:group]
      @registry = opts[:registry]
      @provider = opts[:provider]
      @service = opts[:service]
      @cluster = opts[:cluster]
    end
  end
end