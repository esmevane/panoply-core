require 'spec_helper'
require 'panoply/entities/service'

describe Panoply::Entities::Service do
  subject { Panoply::Entities::Service.new }
  it { subject.must_respond_to :ends_on }
  it { subject.must_respond_to :location }
  it { subject.must_respond_to :name }
  it { subject.must_respond_to :starts_on }
end
