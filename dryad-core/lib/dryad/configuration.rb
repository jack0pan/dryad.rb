module Dryad
  class Configuration
    attr_accessor :consul

    DEFAULT_OPTIONS = {
      consul: {
        host: 'localhost',
        port: 8500
      }
    }

    def initialize(opts = DEFAULT_OPTIONS)
      @consul = opts[:consul]
    end
  end
end