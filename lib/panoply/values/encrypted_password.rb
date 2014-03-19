require 'digest'

module Panoply
  module Values
    class EncryptedPassword
      attr_reader :encrypted_password, :password, :salt

      def initialize options = Hash.new
        @password  = options.fetch(:password) { '' }
        @salt      = options.fetch(:salt, nil) || salted(@password)
        encrypted  = options.fetch(:encrypted_password, nil)
        @encrypted_password = encrypted || encrypt(@password)
      end

      def verify candidate_password
        encrypted_password == encrypt(candidate_password)
      end

      private

      def salted password
        hexdigest Time.now.to_s << password
      end

      def encrypt password
        hexdigest "#{salt}--#{password}"
      end

      def hexdigest string
        Digest::MD5.hexdigest string
      end

    end
  end
end
