require "dryad/configuration"
require "dryad/version"
require "yaml"
require "erb"
require "diplomat"

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
    configure_diplomat
  end

  def self.configure_with_file
    environment = ENV["RAILS_ENV"] || ENV["RACK_ENV"] || "default"
    opts = YAML.load(ERB.new(File.read("config/dryad.yml")).result)[environment] || Configuration::DEFAULT_OPTIONS

    if opts.respond_to? :deep_symbolize_keys!
      opts.deep_symbolize_keys!
    else
      symbolize_keys_deep!(opts)
    end

    @configuration = Configuration.new(opts)
    configure_diplomat
  end

  private
  def self.symbolize_keys_deep!(hash)
    hash.keys.each do |k|
      symkey = k.respond_to?(:to_sym) ? k.to_sym : k
      hash[symkey] = hash.delete k
      symbolize_keys_deep! hash[symkey] if hash[symkey].is_a? Hash
    end
  end

  def self.configure_diplomat
    ::Diplomat.configure do |config|
      config.url = "http://#{configuration.consul[:host]}:#{configuration.consul[:port]}"
    end
  end
end

Dryad.configure_with_file if File.exist?("config/dryad.yml")
