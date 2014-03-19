require 'spec_helper'
require 'panoply/entities/subscription'

describe Panoply::Entities::Subscription do
  subject { Panoply::Entities::Subscription.new }
  it { subject.must_respond_to :plan }
end
