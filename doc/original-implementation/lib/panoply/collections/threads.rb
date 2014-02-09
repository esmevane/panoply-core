module Panoply
  module Collections
    class Threads
      include Enumerable

      attr_reader :data, :model, :repo

      def initialize options = Hash.new
        @data  = Panoply::Data::Message
        @model = Panoply::Models::Thread
        @repo  = Panoply::Repositories::Threads.new options
      end

      def each &block
        contents.each &block
      end

      def self.configurable_fields
        Panoply::Repositories::Threads::CONFIGURABLE - [:labels]
      end

      private

      def contents
        @contents ||= repo.thread_ids.map { |ids| model_for ids: ids }
      end

      def model_for ids: []
        model.new ids: ids, data: data
      end

    end
  end
end