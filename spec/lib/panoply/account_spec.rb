require 'spec_helper'
require 'panoply/account'

describe Panoply::Account do

  let(:email) { "bob@example.com" }
  let(:options) { { name: '', email: email, password: '' } }
  let(:account) { Panoply::Account.register options }

  describe '.authenticate' do
    let(:credentials) { { email: email, password: '' } }
    before { account }
    subject { Panoply::Account.authenticate credentials }
    it { subject.must_be_instance_of Panoply::Aggregates::Account }
  end

  describe '.email_taken?' do
    describe 'with a taken email' do
      before { account }
      subject { Panoply::Account.email_taken? email }
      it { subject.must_equal true }
    end

    describe 'otherwise' do
      before { account }
      subject { Panoply::Account.email_taken? 'random@email.com' }
      it { subject.must_equal false }
    end
  end

  describe '.find' do
    before { account }
    subject { Panoply::Account.find account.id }
    it { subject.must_be_instance_of Panoply::Aggregates::Account }
  end

  describe '.register' do
    subject { account }
    it { subject.must_be_instance_of Panoply::Aggregates::Account }
  end

end
