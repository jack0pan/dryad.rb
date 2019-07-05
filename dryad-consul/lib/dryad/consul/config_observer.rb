module Dryad
  module Consul
    class ConfigObserver < ::Dryad::Core::Observer
      def initialize
        @last_version = 0
      end

      def version=(version)
        @last_version = version
      end

      def update(time, config_desc, exception)
        if exception
          puts "(#{time}) [#{self.class.to_s}] #{exception.message}"
        elsif config_desc
          if @last_version < config_desc.version
            update_self(config_desc)
            @last_version = config_desc.version
          end
        end
      end

      def update_self(config_desc)
        raise "Implement this method"
      end
    end
  end
end
