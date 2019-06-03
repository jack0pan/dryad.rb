require "dryad/version"
require "dryad/configuration"
require "dryad/core"
require "dryad/railtie" if defined?(Rails)
require "dryad/consul"
require "dryad/cluster"

module Dryad
  class << self
    attr_accessor :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def load_config
      config_file = Pathname.new(Rails.root.join("config/dryad.yml"))

      config = if config_file && config_file.exist?
        require "yaml"
        require "erb"
        YAML.load(ERB.new(config_file.read).result) || {}
      else
        raise "Could not load dryad configuration. No such file - #{config_file}"
      end

      config
    rescue Psych::SyntaxError => e
      raise "YAML syntax error occurred while parsing #{config_file}. " \
            "Please note that YAML must be consistently indented using spaces. Tabs are not allowed. " \
            "Error: #{e.message}"
    rescue => e
      raise e, "Cannot load dryad configuration:\n#{e.message}", e.backtrace
    end
  end
end
