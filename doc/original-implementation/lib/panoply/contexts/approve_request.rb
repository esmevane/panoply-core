module Panoply
  module Contexts
    class ApproveRequest
      attr_reader :labels

      def initialize message: nil, recipient: nil
        @labels = message.labels.where do |query|
          query.account_id == recipient.id
        end.extend Panoply::Roles::Approver
      end

      def call
        labels.approve
      end

    end
  end
end
