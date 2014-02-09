module Panoply
  module Contexts
    class ThreadResponse
      attr_reader :body, :delivery, :thread

      def initialize options
        @body     = options.fetch(:body)
        @delivery = Panoply::Contexts::MessageDelivery
        @thread   = options.fetch(:thread)
      end

      def call
        options = { recipients: recipients, body: body }
        message = delivery.new(options).call
        thread.push message
      end

      def recipients
        thread.recipients
      end

    end
  end
end
