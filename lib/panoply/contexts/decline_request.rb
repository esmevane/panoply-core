module Panoply
  module Contexts
    class DeclineRequest
      attr_reader :labels

      def initialize message: nil, recipient: nil
        @labels = message.labels.where do |query|
          query.account_id == recipient.id
        end.extend Panoply::Roles::Decliner
      end

      def call
        labels.decline
      end

    end
  end
end
