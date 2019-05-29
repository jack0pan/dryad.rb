module Dryad
  module Core
    class ConfigDesc
      attr_accessor :path, :payload, :version

      def initialize(path, payload, version)
        @path = path
        @payload = payload
        @version = version
      end
    end
  end
end
