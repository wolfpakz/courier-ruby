module Courier
  class TestPublisher
    include Logging

    attr_reader :messages

    def initialize
      @messages = []
      super
    end

    def publish(topic, message)
      super
      @messages << {topic: topic, message: message}
    end
  end
end
