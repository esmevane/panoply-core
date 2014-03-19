require 'panoply/entities/account'

module Panoply
  module Services
    class RegisterAccount
      attr_accessor :repo
      attr_reader :options

      def initialize options = Hash.new
        @repo    = Panoply::Repositories::Account.new
        @options = options
      end

      def register
        repo.create options
      end

    end
  end
end