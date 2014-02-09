require 'spec_helper'

describe Panoply::Contexts::SearchThreads do

  let(:recipients) { [ Fabricate(:account, id: 2) ] }
  let(:options) { { organization: 'The Fern', recipients: recipients } }
  let(:context) { Panoply::Contexts::SearchThreads.new options }
  let(:context_options) do
    { recipients: recipients }.merge labels: ['The Fern']
  end

  subject { context }

  it { subject.must_respond_to :collection }
  it { subject.must_respond_to :options }
  it { subject.must_respond_to :configurable_fields }

  describe '#call' do
    let(:mock) { MiniTest::Mock.new }
    let(:called) { OpenStruct.new }
    let(:fields) { Panoply::Collections::Threads.configurable_fields }

    subject { context.call }

    it { subject.must_be_instance_of Panoply::Collections::Threads }

    it "loads a Threads collection to perform the search" do
      mock.expect :new, called, [context_options]
      context.stub :configurable_fields, fields do
        context.stub(:collection, mock) { subject }
      end
      mock.verify
    end

  end

end
