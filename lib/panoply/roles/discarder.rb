module Panoply
  module Roles
    module Discarder

      def discard
        remove_content Panoply::LabelStates.get :inbox
        add_content    Panoply::LabelStates.get :discarded
      end

    end
  end
end
