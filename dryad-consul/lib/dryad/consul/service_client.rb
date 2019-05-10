module Dryad
  module Consul
    class ServiceClient
      class << self
        def method_missing(name, *args, &block)
          Diplomat::Service.send(name, *args, &block) || super
        end

        def respond_to_missing?(meth_id, with_private = false)
          access_method?(meth_id) || super
        end
      end
    end
  end
end