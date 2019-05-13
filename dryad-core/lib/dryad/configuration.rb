module Dryad
  class Configuration
    attr_accessor :consul, :namespace, :group, :registry, :service

    DEFAULT_OPTIONS = {
      consul: {
        host: 'localhost',
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
      @service = opts[:service]
    end
  end
end