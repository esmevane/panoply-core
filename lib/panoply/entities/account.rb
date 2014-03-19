module Panoply
  module Entities
    class Account
      attr_accessor :email, :encrypted_password, :id, :name, :salt,
        :subscriptions

      def initialize options = Hash.new
        @email              = options.fetch(:email)              { nil }
        @encrypted_password = options.fetch(:encrypted_password) { nil }
        @id                 = options.fetch(:id)                 { nil }
        @name               = options.fetch(:name)               { nil }
        @salt               = options.fetch(:salt)               { nil }
      end
    end
  end
end