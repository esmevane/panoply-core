require 'spec_helper'
require 'panoply/aggregates/account'

describe Panoply::Aggregates::Account do

  let(:options) do
    { name: 'Glenda B. Pellegrino',
      email: 'GlendaBPellegrino@jourrapide.com',
      password: 'Engi7chee' }
  end

  let(:aggregate) { Panoply::Aggregates::Account.new(options) }

  subject { aggregate }

  it { subject.must_respond_to :id }
  it { subject.must_respond_to :root }

  describe '#root' do
    subject { aggregate.root }
    it { subject.must_be_instance_of Panoply::Entities::Account }
  end

  describe '#to_value' do
    subject { aggregate.to_value }

    it { subject.must_be_instance_of Hash }
    it { subject[:name].must_equal options[:name] }
    it { subject[:email].must_equal options[:email] }
    it { subject[:encrypted_password].wont_be_nil }
    it { subject[:salt].wont_be_nil }

  end
end
