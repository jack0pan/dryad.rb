module Dryad
  module Core
    class ConfigProvider
      def load(path, observer = nil)
        raise "Implement this method"
      end
    end
  end
end
