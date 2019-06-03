require "dryad/version"
require "dryad/railtie" if defined?(Rails)
require "dryad"
require "dryad/consul"
require "dryad/cluster"

module Dryad
  CONFIG_PATH = "config/drayd.yml"

  def self.load_config
    yaml = Pathname.new(CONFIG_PATH)

    config = if yaml && yaml.exist?
      require "yaml"
      require "erb"
      YAML.load(ERB.new(yaml.read).result) || {}
    else
      raise "Could not load dryad configuration. No such file - #{CONFIG_PATH}"
    end

    config
  rescue Psych::SyntaxError => e
    raise "YAML syntax error occurred while parsing #{CONFIG_PATH}. " \
          "Please note that YAML must be consistently indented using spaces. Tabs are not allowed. " \
          "Error: #{e.message}"
  rescue => e
    raise e, "Cannot load dryad configuration:\n#{e.message}", e.backtrace
  end
end