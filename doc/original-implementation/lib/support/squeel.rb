require 'squeel'

module Squeel
  module Nodes
    module Operators

      def has_all *list
        list = "{#{list.map(&:to_s).join(',')}}"
        Operation.new self, :'@>', list
      end

      def has_any *list
        list = "{#{list.map(&:to_s).join(',')}}"
        Operation.new self, :'&&', list
      end

    end
  end
end
