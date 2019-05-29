require "ostruct"

module Dryad
  module Consul
    class KeyValueClient
      class << self

        # Get a value by its key, potentially blocking for the first or next value
        # @param key [String] the key
        # @return [OpenStruct] The base64-decoded value associated with the key
        def get(path)
          OpenStruct.new ::Diplomat::Kv.get(path, decode_values: true).first
        rescue Diplomat::KeyNotFound
          nil
        end
      end
    end
  end
end
