module Panoply
  module Roles
    module Deliverable

      def deliver options = Hash.new, &block
        delivery = create delivery_attributes options
        delivery.update_attribute :thread_ids, [delivery.id]
        delivery.tap &block
      end

      def delivery_attributes options = Hash.new
        options.slice(:body, :sender).delete_if { |_, value| value.nil? }
      end
      private :delivery_attributes

    end
  end
end
