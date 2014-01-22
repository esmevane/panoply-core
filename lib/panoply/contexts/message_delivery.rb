module Panoply
  module Contexts
    class MessageDelivery
      attr_reader :labels, :messages, :options, :recipients

      def initialize options
        @options    = options
        @recipients = options.fetch(:recipients) { [] }
        @labels     = Panoply::Data::Label.extend Panoply::Roles::Notifiable
        @messages   = Panoply::Data::Message.extend Panoply::Roles::Deliverable
      end

      def call
        messages.deliver options do |message|
          labels.notify recipients: recipients, message: message
        end
      end

    end
  end
end
