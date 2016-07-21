require 'spec_helper'

describe Courier do
  it 'has a version number' do
    expect(Courier::VERSION).not_to be nil
  end

  describe '#publisher' do
    describe 'without a publisher configured' do
      it 'raises NotConfigured' do
        expect { Courier.publisher }.to raise_error(Courier::NotConfigured)
      end
    end

    describe 'with a publisher configured' do
      let(:publisher) { double('Publisher') }

      before { Courier.publisher = publisher }
      after { Courier.publisher = nil }

      it 'returns the publisher' do
        expect(Courier.publisher).to eq publisher
      end
    end
  end


  describe '#publish' do
    describe 'without a publisher configured' do
      it 'raises NotConfigured' do
        expect { Courier.publish(:foo, 'bar') }.to raise_error(Courier::NotConfigured)
      end
    end

    describe 'with a publisher configured' do
      let(:publisher) { double('Publisher', publish: true) }

      before { Courier.publisher = publisher }
      after { Courier.publisher = nil }

      it 'publishes a message' do
        Courier.publish(:foo, 'bar')
        expect(publisher).to have_received(:publish).with(:foo, 'bar')
      end
    end
  end
end
