module Panoply
  module Roles
    module Notifiable

      def notify recipients: [], message: nil
        recipients.each do |recipient|
          notification account: recipient, message: message
        end
      end

      def notification account: nil, message: nil
        create account: account, message: message, content: content
      end

      def content
        Panoply::LabelStates.all :new
      end

    end
  end
end
