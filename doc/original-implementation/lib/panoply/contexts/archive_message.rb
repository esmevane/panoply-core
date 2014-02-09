module Panoply
  module Contexts
    class ArchiveMessage
      attr_reader :labels

      def initialize message: nil, recipient: nil
        @labels = message.labels.where do |query|
          query.account_id == recipient.id
        end.extend Panoply::Roles::Archiver
      end

      def call
        labels.archive
      end

    end
  end
end
