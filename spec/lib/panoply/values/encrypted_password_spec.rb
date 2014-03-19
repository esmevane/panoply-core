require 'spec_helper'
require 'panoply/values/encrypted_password'

describe Panoply::Values::EncryptedPassword do
  let(:password) { "Heinous Abby Was So Crabby" }
  let(:options) { { salt: 'stuff', password: password } }
  let(:value) { Panoply::Values::EncryptedPassword.new(options) }

  subject { value }

  it { subject.must_respond_to :salt }
  it { subject.must_respond_to :password }

  describe '#verify' do

    describe 'with the correct password' do
      subject { value.verify(password) }
      it { subject.must_equal true }
    end

    describe 'otherwise' do
      subject { value.verify('') }
      it { subject.must_equal false }
    end

  end
end
