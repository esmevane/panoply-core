require 'panoply/entities/account'

module Panoply
  module Services
    class AuthenticateAccount
      attr_accessor :repo, :email, :password

      def initialize options = Hash.new
        @repo     = Panoply::Repositories::Account.new
        @email    = options.fetch(:email) { '' }
        @password = options.fetch(:password) { '' }
      end

      def authenticate
        account = repo.find_by_email email
        return nil if account.nil?
        return account if account.verify password
      end

    end
  end
end