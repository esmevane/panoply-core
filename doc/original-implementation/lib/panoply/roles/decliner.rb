module Panoply
  module Roles
    module Decliner

      def decline
        remove_content Panoply::LabelStates.get :request
        add_content    Panoply::LabelStates.get :declined
      end

    end
  end
end
