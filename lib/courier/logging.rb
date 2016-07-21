module Courier
  module Logging
    def self.included(source)
      source.send(:include, InstanceMethods)
    end

    module InstanceMethods
      def publish(topic, message)
        logger.info log_message(topic, message)
      end

      def log_message(topic, message)
        "[%s] Message from %s: %s" % [logging_prefix, topic.to_s, message]
      end

      def logger
        @logger ||= ::Logger.new(STDOUT)
      end

      def logger=(value)
        @logger = value
      end

      def logging_prefix
        name = self.class.name
        index = name.rindex('::')

        index ? name[(index + 2)..-1] : name
      end

      def logging_prefix=(value)
        @logging_prefix = value
      end
    end
  end
end

require 'logger'