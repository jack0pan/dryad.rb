require "dryad/consul/version"
require "diplomat"

module Dryad
  module Consul
    class Error < StandardError; end

    ::Diplomat.configure do |config|
      config.url = "http://#{Dryad.configuration.consul[:host]}:#{Dryad.configuration.consul[:port]}"
    end
  end
end
