module Panoply
  module Repositories
    class Threads

      CONFIGURABLE = [ :data, :ids, :labels, :limit, :model,
        :offset, :page, :recipients ]

      def initialize options = Hash.new
        limit   = options.fetch(:limit) { defaults[:limit] }
        page    = options.fetch(:page)  { defaults[:page] }
        options = defaults.merge options.merge offset: (page - 1) * limit
        @config = OpenStruct.new options
      end

      def call
        criteria.select { thread_ids }.uniq.limit(limit)
      end

      def thread_ids
        call.map &:thread_ids
      end

      private

      attr_reader :config

      delegate *CONFIGURABLE, to: :config

      def criteria
        [ data.all ].tap do |array|
          array.push data.labeled_by(*labels)            if labels.present?
          array.push data.for_recipients(*recipient_ids) if recipients.present?
          array.push data.where(id: ids)                 if ids.present?
          array.push data.offset(offset)                 if offset?
        end.reduce &:merge
      end

      def defaults
        { data:       Panoply::Data::Message,
          ids:        Array.new,
          labels:     Array.new,
          limit:      50,
          page:       1,
          recipients: Array.new }
      end

      def offset?
        offset >= limit
      end

      def recipient_ids
        recipients.map(&:id)
      end

    end
  end
end