require 'singleton'
require 'concurrent'

module Dryad
  module Consul
    class ConfigProvider < Dryad::Core::ConfigProvider
      include Singleton
      WATCHER_EXECUTION_INTERVAL = 5 * 60

      def initialize
        @timers = {}
      end

      def load(path, observer = nil)
        config = Dryad::Consul::KeyValueClient.get(path)
        if config.nil?
          nil
        else
          observer.version = config.ModifyIndex unless observer.nil?
          add_observer(observer, path)
          Dryad::Core::ConfigDesc.new(path, config.Value, config.ModifyIndex)
        end
      end

      private
      def add_observer(observer, path)
        if observer && observer.is_a?(Dryad::Core::Observer)
          if @timers.has_key?(path)
            @timers[path].add_observer(observer)
          else
            timer = Concurrent::TimerTask.new(execution_interval: WATCHER_EXECUTION_INTERVAL) do
              config = Dryad::Consul::KeyValueClient.get(path)
              if config.nil?
                nil
              else
                Dryad::Core::ConfigDesc.new(path, config.Value, config.ModifyIndex)
              end
            end
            timer.add_observer(observer)
            timer.execute
            @timers[path] = timer
          end
        end
      end
    end
  end
end
