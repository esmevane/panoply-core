require 'spec_helper'

describe Panoply::Collections::Threads do
  let(:collection) { Panoply::Collections::Threads.new }

  subject { collection }

  it { subject.must_respond_to :data }
  it { subject.must_respond_to :model }
  it { subject.must_respond_to :repo }

  describe 'initialization' do

    subject { collection.count }

    it 'creates one thread per applicable message' do
      Fabricate :message

      messages    = Fabricate.times 2, :message
      message_ids = messages.map &:id

      messages.each do |message|
        message.update_attributes thread_ids: message_ids
      end

      subject.must_equal 2
    end
  end

  describe 'scoping to a recipient' do
    let(:recipients) { [Fabricate(:account, id: 1)] }
    let(:bare_message) { Fabricate :bare_message }

    let(:collection) do
      Panoply::Collections::Threads.new recipients: recipients
    end

    subject { collection.count }

    before do
      recipients.each do |recipient|
        Fabricate :label, account: recipient, message: bare_message,
          content: Panoply::LabelStates.all(:new)
      end
      Fabricate.times 3, :bare_message
    end

    it 'retrieves threads for a recipient' do
      subject.must_equal 1
    end

  end

  describe 'pagination' do

    let(:options) { Hash.new }
    let(:collection) { Panoply::Collections::Threads.new(options) }
    subject { collection.count }

    describe 'default behavior' do
      it 'is 50 threads' do
        Fabricate.times 51, :message
        subject.must_equal 50
      end
    end

    describe 'setting limits' do
      let(:limit) { 2 }
      let(:options) { { limit: limit } }
      it 'can be set arbitrarily' do
        Fabricate.times 3, :message
        subject.must_equal limit
      end
    end

    describe 'setting page' do
      let(:page) { 2 }
      let(:options) { { page: page, limit: 2 } }
      it 'can be set arbitrarily' do
        Fabricate.times 3, :message
        subject.must_equal 1
      end
    end

  end

  describe 'scoping by label' do
    let(:labels) { ['Inbox', 'Unread'] }
    let(:collection) { Panoply::Collections::Threads.new labels: labels }
    subject { collection.count }

    before do
      Fabricate :message
      Fabricate :read_message
      Fabricate :archived_message
    end

    it 'retrieves the threads with all applicable labels' do
      subject.must_equal 1
    end
  end

end
