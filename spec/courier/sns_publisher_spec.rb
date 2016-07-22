require 'spec_helper'

RSpec.describe Courier::SnsPublisher, type: :model do
  subject(:publisher) { Courier::SnsPublisher.new(sns_topics) }

  let(:sns_topics) {
    {new_donation: "arn:scooby:dooby:doo:where:are:you"}
  }
  let(:logger_double) { instance_double('Logger', :info => true) }

  before { publisher.logger = logger_double }

  describe '#sns_client' do
    it 'defaults to a new AWS::SNS::Client' do
      expect(publisher.sns_client).to be_an_instance_of(Aws::SNS::Client)
    end
  end

  describe '#publish to :new_donation' do
    let(:sns_client_double) { double('Aws::SNS::Client', :publish => true) }
    before { publisher.sns_client = sns_client_double }

    it 'sends :publish to #sns_client with the topic ARN and message' do
      expect(sns_client_double).to receive(:publish).with({:topic_arn => 'arn:scooby:dooby:doo:where:are:you',
                                                           :message => {id: 9023, created_at: '2016-04-28 06:56:32'}.to_json})
      publisher.publish(:new_donation, {id: 9023, created_at: '2016-04-28 06:56:32'})
    end

    it 'logs topic and message' do
      expect(logger_double).to receive(:info).with('[SnsPublisher] Message from new_donation: {:id=>9023}')
      publisher.publish(:new_donation, {id: 9023})
    end
  end
end