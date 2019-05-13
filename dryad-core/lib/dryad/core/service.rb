module Dryad
  module Core
    class Service
      attr_accessor :name, :address, :group, :portals, :priority, :load_balancing

      TYPE = "microservice"

      DEFAULT_OPTIONS = {
        :portals => [],
        :load_balancing => []
      }

      def initialize(options = {})
        options = DEFAULT_OPTIONS.merge(options)
        @name = options[:name]
        @address = options[:address]
        @group = options[:group]
        @portals = options[:portals]
        @priority = options[:priority]
        @load_balancing = options[:load_balancing]
      end

      def type_name
        Dryad::Core::Service::TYPE
      end

      class << self
        def full_name(schema, name)
          case schema
          when Schema::HTTP
            name
          else
            "#{name}-#{schema}"
          end
        end
      end
    end
  end
end
