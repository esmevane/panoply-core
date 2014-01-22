module Panoply
  module Models
    class Thread
      include Enumerable

      attr_accessor :messages
      attr_reader :account_data, :message_data

      def initialize ids: Array.new, data: Panoply::Data::Message
        @account_data = Panoply::Data::Account
        @message_data = data
        @messages     = data.where { thread_ids.has_all *ids }
      end

      def each &block
        messages.each &block
      end

      def push message
        messages.push message
        message_scope.update_all "thread_ids = ARRAY[#{message_ids.join(",")}]"
        self
      end

      def last
        to_a.last
      end

      def recipients
        account_ids = messages.joins { labels.account }.
          select { labels.account_id }
        account_data.where { id.in account_ids }
      end

      private

      def message_scope
        message_data.where { |query| query.id.in message_ids }
      end

      def message_ids
        Array messages.map &:id
      end

    end
  end
end
