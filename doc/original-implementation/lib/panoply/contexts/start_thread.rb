module Panoply
  module Contexts
    class StartThread
      attr_reader :collection, :options

      def initialize options = Hash.new
        @collection = Panoply::Collections::Threads
        @options    = options
      end

      def call
        delivery.new(options).call
      end

      def delivery
        Panoply::Contexts::MessageDelivery
      end

    end
  end
end
