require 'spec_helper'
require 'panoply/factories/account'

describe Panoply::Factories::Account do

  let(:options) do
    { name: 'Glenda B. Pellegrino',
      email: 'GlendaBPellegrino@jourrapide.com',
      password: 'Engi7chee' }
  end

  let(:list) { [options] }
  let(:factory) { Panoply::Factories::Account.new(list) }

  describe '#build' do
    subject { factory.build }
    it { subject.length.must_equal list.length }
    it { subject.first.must_be_instance_of Panoply::Aggregates::Account }
  end

  describe '.create' do
    subject { Panoply::Factories::Account.create options }
    it { subject.must_be_instance_of Panoply::Aggregates::Account }
  end

end
