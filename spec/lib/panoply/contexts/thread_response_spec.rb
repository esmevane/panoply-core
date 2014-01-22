require 'spec_helper'

describe Panoply::Contexts::ThreadResponse do
  let(:caller) { OpenStruct.new call: Panoply::Data::Message.new }
  let(:mock) { MiniTest::Mock.new }
  let(:thread) { MiniTest::Mock.new }
  let(:options) { { body: "", thread: thread } }
  let(:context) { Panoply::Contexts::ThreadResponse.new options }
  let(:context_options) { { body: "", recipients: [] } }

  subject { context }

  it { subject.must_respond_to :body }
  it { subject.must_respond_to :delivery }
  it { subject.must_respond_to :thread }

  describe '#call' do
    subject { context.call }

    it 'calls the MessageDelivery context' do
      mock.expect :new, caller, [Hash]
      thread.expect :push, caller.call, [caller.call]
      context.stub :recipients, [] do
        context.stub(:delivery, mock) { subject }
      end
      mock.verify
    end

    it 'builds a message delivery parameter hash' do
      mock.expect :new, caller, [context_options]
      thread.expect :push, caller.call, [caller.call]
      context.stub :recipients, [] do
        context.stub(:delivery, mock) { subject }
      end
      mock.verify
    end

    it 'pushes the resulting message into the thread' do
      mock.expect :new, caller, [Hash]
      thread.expect :push, caller.call, [caller.call]
      context.stub :recipients, [] do
        context.stub(:delivery, mock) { subject }
      end
      thread.verify
    end

  end

  describe '#recipients' do
    subject { context.recipients }
    it "delegates to #thread" do
      thread.expect :recipients, [], []
      context.stub(:thread, thread) { subject }
      thread.verify
    end
  end

end

