module Dryad
  module DTO
    class ServiceInstance
      attr_accessor :name, :schema, :address, :port

      def initialize(options = {})
        @name = options[:name]
        @schema = options[:schema]
        @address = options[:address]
        @port = options[:port]
      end
    end
  end
end
