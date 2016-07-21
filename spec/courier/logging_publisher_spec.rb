require 'spec_helper'

RSpec.describe Courier::LoggingPublisher, type: :model do
  subject(:publisher) { Courier::LoggingPublisher.new }

  describe '#logger' do
    it 'defaults to a new Logger' do
      expect(publisher.logger).to respond_to(:info)
    end
  end


  describe '#logging_prefix' do
    it 'matches the class name' do
      expect(publisher.logging_prefix).to eq('LoggingPublisher')
    end
  end


  describe '#publish' do
    let(:topic) { :foo_happened }
    let(:message) { {data: 123} }
    let(:logger_double) { instance_double('Logger', :info => true) }

    before { publisher.logger = logger_double }

    it 'logs topic and message' do
      expect(logger_double).to receive(:info).with("[LoggingPublisher] Message from foo_happened: {:data=>123}").once
      publisher.publish(topic, message)
    end
  end
end