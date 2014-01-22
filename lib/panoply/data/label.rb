module Panoply
  module Data
    class Label < ActiveRecord::Base
      belongs_to :message, class_name: 'Panoply::Data::Message'
      belongs_to :account, class_name: 'Panoply::Data::Account'

      scope :labeled_by, -> *labels do
        where { |query| query.content.has_all *labels }
      end

      class << self
        # The not-null constraint on labels.content causes this to
        # explode if the resulting array is empty.
        #
        def remove_content label
          update_all "content = (select array_agg(label) from " +
            "(select unnest(content) as label) unnested " +
            "where not label = '#{label}')"
        end

        def add_content label
          update_all "content = array_append(content, '#{label}')"
        end
      end

    end
  end
end
