require 'spec_helper'

describe Panoply::Models::Thread do
  let(:mock) { MiniTest::Mock.new }
  let(:model) { Panoply::Models::Thread.new }
  let(:new_message) { OpenStruct.new id: 1 }

  subject { model }

  it { subject.must_respond_to :account_data }
  it { subject.must_respond_to :message_data }
  it { subject.must_respond_to :messages }

  describe '#last' do
    subject { model.last }
    it "is the last message" do
      model.stub :messages, [new_message] do
        model.last.must_equal new_message
      end
    end
  end

  describe '#push' do
    subject { model.push new_message }

    it 'updates the attributes on given messages' do
      mock.expect :update_all, nil, [String]
      model.stub(:message_scope, mock) { subject }
      mock.verify
    end

    it 'adds the message to the list' do
      subject
      model.must_include new_message
    end

  end

  describe '#recipients' do
    subject { model.recipients }
    it "retrieves the relevant accounts" do
      mock.expect :where, nil, []
      model.stub(:account_data, mock) { subject }
      mock.verify
    end
  end
end
