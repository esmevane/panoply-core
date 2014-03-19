require 'spec_helper'
require 'panoply/services/register_account'

describe Panoply::Services::RegisterAccount do

  let(:options) do
    { name: "Elizabeth S. Barraza",
      email: 'ElizabethSBarraza@jourrapide.com',
      password: 'aiqu1Chee' }
  end

  let(:factory) { Panoply::Services::RegisterAccount.new options }

  subject { factory }

  it { subject.must_respond_to :repo }

  describe '#register' do
    let(:repo_mock) { MiniTest::Mock.new }
    let(:account) { Object.new }

    subject { factory.register }

    it { subject.must_be_instance_of Panoply::Aggregates::Account }

    it "passes the given params to the repo" do
      factory.repo = repo_mock
      factory.repo.expect :create, account, [options]
      factory.register
      factory.repo.verify
    end

  end

end
