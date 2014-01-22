module Panoply
  module Components
    class Conversation
      attr_reader :account, :search_threads, :start_thread, :thread_response

      def initialize account: nil
        @account         = account
        @search_threads  = Panoply::Contexts::SearchThreads
        @start_thread    = Panoply::Contexts::StartThread
        @thread_response = Panoply::Contexts::ThreadResponse
      end

      def create options = Hash.new
        options = options.merge sender: account
        start_thread.new(options).call
      end

      def inbox options = Hash.new
        search options.merge labels: [ 'Inbox' ]
      end

      def reply options = Hash.new
        options = options.merge sender: account
        thread_response.new(options).call
      end

      def search options = Hash.new
        options = options.merge recipients: [account]
        search_threads.new(options).call
      end

      def thread message_id
        search(ids: message_id).first
      end

      def self.thread account, message_id
        new(account: account).thread message_id
      end

      def unread options = Hash.new
        search options.merge labels: [ 'Unread' ]
      end

    end
  end
end
