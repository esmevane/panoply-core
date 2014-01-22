require 'spec_helper'

CherryCoke       = Struct.new :flavor
CherryCokeRecipe = Struct.new :flavor

describe Panoply::Registry do
  describe 'registering map relationships' do
    before do
      Panoply::Registry.register { map CherryCoke, to: CherryCokeRecipe }
    end

    describe '.recipe' do
      subject { Panoply::Registry.recipe CherryCoke }
      it { subject.must_equal CherryCokeRecipe }
    end

    describe '.product' do
      subject { Panoply::Registry.product CherryCokeRecipe }
      it { subject.must_equal CherryCoke }
    end
  end
end
