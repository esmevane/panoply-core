require 'spec_helper'
require 'panoply/services/authenticate_account'

describe Panoply::Services::AuthenticateAccount do

  let(:email) { 'KandraAKepley@teleworm.us' }
  let(:password) { 'Beep4suG' }

  let(:options) do
    { name: 'Kandra A. Kepley', email: email, password: password }
  end

  let(:credentials) do
    { email: email, password: password }
  end

  let(:service) { Panoply::Services::AuthenticateAccount.new(credentials) }
  let(:account) { Panoply::Account.register options }

  before(:each) { account }

  subject { service }

  it { subject.must_respond_to :repo }
  it { subject.must_respond_to :email }
  it { subject.must_respond_to :password }

  describe '#authenticate' do
    before { account }
    subject { service.authenticate }

    describe "with valid credentials" do
      it { subject.id.must_equal account.id }
    end

    describe 'with a bad email' do
      let(:credentials) { { email: '', password: password } }
      it { subject.must_be_nil }
    end

    describe 'with a bad password' do
      let(:credentials) { { email: email, password: '' } }
      it { subject.must_be_nil }
    end

  end
end
