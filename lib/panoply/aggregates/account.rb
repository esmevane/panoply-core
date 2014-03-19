module Panoply
  module Aggregates
    class Account
      extend Forwardable

      def_delegators :password, :encrypted_password, :salt
      def_delegators :root, :id, :email, :name

      attr_reader :password, :root

      def initialize options = Hash.new
        @password = Panoply::Values::EncryptedPassword.new options
        @root     = Panoply::Entities::Account.new options
      end

      def verify candidate_password
        password.verify candidate_password
      end

      def id= id
        root.id = id
      end

      def to_value
        { name: name, id: id, email: email, salt: salt,
          encrypted_password: encrypted_password }
      end

    end
  end
end
