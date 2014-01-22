module Panoply
  module Roles
    module Approver

      def approve
        remove_content Panoply::LabelStates.get :request
        add_content    Panoply::LabelStates.get :approved
      end

    end
  end
end
