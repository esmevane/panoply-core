require 'spec_helper'
require 'panoply/services/search_services'

describe Panoply::Services::SearchServices do
  let(:service) { Panoply::Services::SearchServices.new }

  subject { service }

  describe '#results' do
    subject { service.results }
    it { subject.must_be_instance_of Array }
  end

end
