require 'spec_helper'

describe Panoply::Contexts::StartThread do
  let(:options) { Hash.new }
  let(:context) { Panoply::Contexts::StartThread.new options }

  subject { context }

  it { subject.must_respond_to :collection }
  it { subject.must_respond_to :delivery }
  it { subject.must_respond_to :options }

  describe '#delivery' do
    subject { context.delivery }
    it { subject.must_equal Panoply::Contexts::MessageDelivery }
  end

  describe '#call' do
    let(:mock) { MiniTest::Mock.new }
    let(:caller) { OpenStruct.new call: true }

    it 'creates a new message delivery with the given options' do
      mock.expect :new, caller, [options]
      context.stub(:delivery, mock) { subject.call }
      mock.verify
    end
  end

end
