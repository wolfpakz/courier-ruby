require "courier/version"

module Courier
  class NotConfigured < StandardError; end

  @@publisher = nil

  def self.publisher
    @@publisher || raise(NotConfigured, 'Configure a publisher first e.g. `Courier.publisher = Courier::TestPublisher.new`')
  end

  def self.publisher=(value)
    @@publisher = value
  end

  def self.publish(topic, message)
    publisher.publish(topic, message)
  end
end

require 'courier/logging'
require 'courier/logging_publisher'
require 'courier/test_publisher'
require 'courier/sns_publisher'
