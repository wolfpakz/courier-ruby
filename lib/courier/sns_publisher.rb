require 'aws-sdk'

module Courier
  class SnsPublisher
    attr_accessor :sns_config, :sns_client, :region

    include Logging

    def initialize(sns_config, region: 'us-east-1')
      @sns_config = sns_config
      @region = region
    end

    def publish(topic, message)
      arn = arn_lookup(topic)

      super
      sns_client.publish({topic_arn: arn,
                          message: message.to_json})
    end

    def sns_client
      @sns_client ||= ::Aws::SNS::Client.new(region: region)
    end

    private
    def arn_lookup(topic)
      sns_config.include?(topic) ? sns_config[topic] : raise(topic_error(topic))
    end

    def topic_error(topic)
      Courier::NotConfigured.new "SNS topic \"#{topic}\" is not configured"
    end
  end
end
