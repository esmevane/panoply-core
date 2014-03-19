require 'panoply/entities/account'

module Panoply
  module Factories
    class Account
      attr_reader :aggregate, :list

      def initialize list
        @aggregate = Panoply::Aggregates::Account
        @list      = list
      end

      def build
        list.map { |item| aggregate_for item }
      end

      def self.build list
        new(list).build
      end

      def self.create item
        list = [item]
        build(list).first
      end

      private

      def password_for item
        Panoply::Values::EncryptedPassword.new salt: item[:salt],
          encrypted_password: item[:encrypted_password],
          password: item[:password]
      end

      def aggregate_for item
        password = password_for item

        item = item.merge salt: password.salt,
          encrypted_password: password.encrypted_password

        aggregate.new item
      end

    end
  end
end
