require 'sequel'

module Panoply
  module Repositories
    class Account
      attr_accessor :store

      def initialize
        @store = MemoryStore[:accounts]
      end

      def count
        store.count
      end

      def create options = Hash.new
        Panoply::Factories::Account.create(options).tap do |account|
          id = store.insert account.to_value
          account.id = id
        end
      end

      def find id
        if account = store.where(id: id).first
          Panoply::Aggregates::Account.new account
        end
      end

      def find_by_email email
        if account = store.where(email: email).first
          Panoply::Aggregates::Account.new account
        end
      end

    end
  end
end
