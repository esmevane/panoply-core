require 'spec_helper'
require 'panoply/entities/account'

describe Panoply::Entities::Account do
  subject { Panoply::Entities::Account.new }
  it { subject.must_respond_to :email }
  it { subject.must_respond_to :id }
  it { subject.must_respond_to :name }
  it { subject.must_respond_to :encrypted_password }
  it { subject.must_respond_to :salt }
  it { subject.must_respond_to :subscriptions }

  describe '#new' do

    let(:options) do
      { name: 'Vella E. Hosey',
        id: 1,
        email: 'VellaEHosey@armyspy.com',
        encrypted_password: 'Ees0eing',
        salt: '1exetbrb15719' }
    end

    let(:entity) { Panoply::Entities::Account.new options }

    describe '#email' do
      subject { entity.email }
      it { subject.must_equal options[:email] }
    end

    describe '#id' do
      subject { entity.id }
      it { subject.must_equal options[:id] }
    end

    describe '#name' do
      subject { entity.name }
      it { subject.must_equal options[:name] }
    end

    describe '#salt' do
      subject { entity.salt }
      it { subject.must_equal options[:salt] }
    end

    describe '#encrypted_password' do
      subject { entity.encrypted_password }
      it { subject.must_equal options[:encrypted_password] }
    end

  end
end
