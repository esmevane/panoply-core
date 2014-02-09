module Panoply
  module Contexts
    class SearchThreads
      attr_reader :collection, :options

      def initialize options = Hash.new
        @collection = Panoply::Collections::Threads
        @options    = options
      end

      def call
        collection.new thread_config
      end

      def configurable_fields
        collection.configurable_fields
      end

      private

      def thread_config
        config = options.slice(*configurable_fields)
        config = config.merge(labels: labels) if labels.present?
        config
      end

      def labels
        @labels ||= options.except(*configurable_fields).values.flatten
      end

    end
  end
end
