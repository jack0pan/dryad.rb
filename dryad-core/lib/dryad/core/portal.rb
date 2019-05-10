require 'securerandom'

module Dryad
  module Core
    class Portal
      attr_accessor :id, :schema, :port, :pattern, :check, :non_certifications

      DEFAULT_OPTIONS = {
        :non_certifications => []
      }

      def initialize(options = DEFAULT_OPTIONS)
        @id = SecureRandom.uuid
        @schema = options[:schema]
        @port = options[:port]
        @pattern = options[:pattern]
        @non_certifications = options[:non_certifications]
      end
    end
  end
end
