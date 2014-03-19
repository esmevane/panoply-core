require 'spec_helper'
require 'panoply/repositories/account'

describe Panoply::Repositories::Account do
  let(:options) do
    { name: 'Kandra A. Kepley',
      email: 'KandraAKepley@teleworm.us',
      password: 'Beep4suG' }
  end

  let(:repo) { Panoply::Repositories::Account.new }

  subject { repo }

  it { subject.must_respond_to :store }

  describe '#find' do
    let(:account) { repo.create options }
    subject { repo.find(account.id).id }
    it { subject.must_equal account.id }
  end

  describe '#find_by_email' do
    let(:account) { repo.create options }
    subject { repo.find_by_email(account.email).email }
    it { subject.must_equal account.email }
  end

  describe '#count' do
    before { repo.create options }
    subject { repo.count }
    it { subject.must_equal 1 }
  end

  describe '#create' do
    subject { repo.create options }
    it { subject.must_be_instance_of Panoply::Aggregates::Account }
    it { subject.id.wont_be_nil }
  end
end
