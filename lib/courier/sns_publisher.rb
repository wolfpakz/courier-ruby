require 'aws-sdk'

module Courier
  class SnsPublisher
    attr_accessor :sns_config, :sns_client

    include Logging

    def initialize(sns_config)
      @sns_config = sns_config
    end

    def publish(topic, message)
      arn = arn_lookup(topic)

      super
      sns_client.publish({topic_arn: arn,
                          message: message.to_json})
    end

    def sns_client
      @sns_client ||= ::AWS::SNS::Client.new
    end

    private
    def arn_lookup(topic)
      sns_config.include?(topic) ? sns_config[topic] : raise(topic_error(topic))
    end

    def topic_error(topic)
      Courier::NotConfigured.new "AWS SNS topic \"#{topic}\" is not configured"
    end
  end
end
