require 'spec_helper'

describe Panoply::Components::Conversation do

  let(:account) { Fabricate :account }
  let(:conversation) { described_class.new account: account }
  let(:described_class) { Panoply::Components::Conversation }
  let(:recipients) { Fabricate.times 2, :account }

  describe '#create' do
    let(:options) { { body: "Message contents" } }
    let(:mock) { MiniTest::Mock.new }
    let(:caller) { OpenStruct.new call: true }
    let(:context_options) { options.merge sender: account }

    subject { conversation.create options }

    it 'calls the StartThread context' do
      mock.expect :new, caller, [context_options]
      conversation.stub(:start_thread, mock) { subject }
      mock.verify
    end

  end

  describe '#inbox' do
    let(:options) { { body: "Message contents" } }
    let(:mock) { MiniTest::Mock.new }
    let(:caller) { OpenStruct.new call: true }
    let(:inbox) { Panoply::LabelStates.get(:inbox) }

    let(:context_options) do
      options.merge recipients: [account], labels: [inbox]
    end

    subject { conversation.inbox options }

    it { subject.must_be_instance_of Panoply::Collections::Threads }

    it 'calls the SearchThreads context' do
      mock.expect :new, caller, [Hash]
      conversation.stub(:search_threads, mock) { subject }
      mock.verify
    end

    it 'passes the Inbox label to the search context' do
      mock.expect :new, caller, [context_options]
      conversation.stub(:search_threads, mock) { subject }
      mock.verify
    end

  end

  describe '#reply' do
    let(:caller) { OpenStruct.new call: true }
    let(:mock) { MiniTest::Mock.new }
    let(:thread) { MiniTest::Mock.new }
    let(:options) { { thread: thread, body: "Message contents" } }
    let(:context_options) { options.merge sender: account }

    subject { conversation.reply options }

    it 'calls the SearchThreads context' do
      mock.expect :new, caller, [Hash]
      conversation.stub(:thread_response, mock) { subject }
      mock.verify
    end

    it 'merges its account into the search recipients' do
      mock.expect :new, caller, [context_options]
      conversation.stub(:thread_response, mock) { subject }
      mock.verify
    end

  end

  describe '#search' do
    let(:options) { { body: "Message contents" } }
    let(:context_options) { options.merge recipients: [account] }
    let(:mock) { MiniTest::Mock.new }
    let(:caller) { OpenStruct.new call: true }

    subject { conversation.search options }

    it { subject.must_be_instance_of Panoply::Collections::Threads }

    it 'calls the SearchThreads context' do
      mock.expect :new, caller, [Hash]
      conversation.stub(:search_threads, mock) { subject }
      mock.verify
    end

    it 'merges its account into the search recipients' do
      mock.expect :new, caller, [context_options]
      conversation.stub(:search_threads, mock) { subject }
      mock.verify
    end

  end

  describe '#thread' do
    let(:target_message) { Fabricate :message }
    let(:recipient) { target_message.labels.first.account }
    let(:conversation) { described_class.new account: recipient }
    subject { conversation.thread target_message.id }
    it { subject.must_be_instance_of Panoply::Models::Thread }
    it { subject.must_include target_message }
  end

  describe '.thread' do
    let(:target_message) { Fabricate :message }
    let(:recipient) { target_message.labels.first.account }
    let(:thread) { described_class.thread recipient, target_message.id }
    subject { thread }
    it { subject.must_include target_message }
  end

  describe '#unread' do
    let(:options) { { body: "Message contents" } }
    let(:mock) { MiniTest::Mock.new }
    let(:caller) { OpenStruct.new call: true }

    let(:context_options) do
      options.merge recipients: [account], labels: ["Unread"]
    end

    subject { conversation.unread options }

    it { subject.must_be_instance_of Panoply::Collections::Threads }

    it 'calls the SearchThreads context' do
      mock.expect :new, caller, [Hash]
      conversation.stub(:search_threads, mock) { subject }
      mock.verify
    end

    it 'passes the Inbox label to the search context' do
      mock.expect :new, caller, [context_options]
      conversation.stub(:search_threads, mock) { subject }
      mock.verify
    end

  end
end
