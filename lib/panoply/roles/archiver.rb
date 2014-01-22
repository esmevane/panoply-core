module Panoply
  module Roles
    module Archiver

      def archive
        remove_content Panoply::LabelStates.get :inbox
      end

    end
  end
end
