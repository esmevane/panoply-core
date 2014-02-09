require 'spec_helper'

describe Panoply::Contexts::MessageDelivery do

  let(:sender) { Fabricate :account, id: 1 }
  let(:recipients) { [ Fabricate(:account, id: 2) ] }
  let(:options) { { recipients: recipients, body: "", sender: sender } }
  let(:context) { Panoply::Contexts::MessageDelivery.new options }

  subject { context }

  it { subject.must_respond_to :labels }
  it { subject.must_respond_to :messages }
  it { subject.must_respond_to :options }
  it { subject.must_respond_to :recipients }

  describe '#call' do
    let(:mock) { MiniTest::Mock.new }
    let(:return_value) { OpenStruct.new deliver: nil }

    subject { context.call }

    it { subject.must_be_instance_of Panoply::Data::Message }
    it { subject.sender_id.must_equal sender.id }
    it { subject.thread_ids.must_equal [subject.id] }

    it "creates a new message delivery" do
      mock.expect :deliver, Fabricate(:message), [Hash]
      context.stub(:messages, mock) { subject }
      mock.verify
    end

    it "builds a new label for each recipient" do
      mock.expect :notify, Fabricate(:label), [Hash]
      context.stub(:labels, mock) { subject }
      mock.verify
    end

  end

end
