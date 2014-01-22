module Panoply
  module Contexts
    class DiscardMessage
      attr_reader :labels

      def initialize message: nil, recipient: nil
        @labels = message.labels.where do |query|
          query.account_id == recipient.id
        end.extend Panoply::Roles::Discarder
      end

      def call
        labels.discard
      end

    end
  end
end
