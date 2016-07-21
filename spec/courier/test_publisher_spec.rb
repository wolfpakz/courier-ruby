require 'spec_helper'

RSpec.describe Courier::TestPublisher, type: :model do
  subject(:publisher) { Courier::TestPublisher.new }

  let(:logger_double) { instance_double('Logger', :info => true) }

  before { publisher.logger = logger_double }

  describe '#publish' do
    let(:last_message) { publisher.messages.last }

    it 'saves the topic and message' do
      publisher.publish(:new_donation, {id: 123})
      expect(last_message).to eq({topic: :new_donation, message: {id: 123}})
    end

    it 'logs topic and message' do
      expect(logger_double).to receive(:info).with("[TestPublisher] Message from new_donation: {:id=>123}")
      publisher.publish(:new_donation, {id: 123})
    end
  end
end