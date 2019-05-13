require "dryad/configuration"
require "dryad/core"
require "yaml"
require "erb"

DRYAD_COFNIG_FILE = ENV["DRYAD_CONFIG_FILE"] || "config/dryad.yml"

module Dryad
  class Error < StandardError; end

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.configure_with_file
    environment = ENV["RAILS_ENV"] || ENV["RACK_ENV"] || "default"
    opts = YAML.load(ERB.new(File.read(DRYAD_COFNIG_FILE)).result)[environment] || Configuration::DEFAULT_OPTIONS

    if opts.respond_to? :deep_symbolize_keys!
      opts.deep_symbolize_keys!
    else
      symbolize_keys_deep!(opts)
    end

    @configuration = Configuration.new(opts)
  end

  private
  def self.symbolize_keys_deep!(hash)
    hash.keys.each do |k|
      symkey = k.respond_to?(:to_sym) ? k.to_sym : k
      hash[symkey] = hash.delete k
      symbolize_keys_deep! hash[symkey] if hash[symkey].is_a? Hash
    end
  end
end

Dryad.configure_with_file if File.exist?(DRYAD_COFNIG_FILE)
