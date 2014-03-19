module Panoply
  module Account

    def self.authenticate options = Hash.new
      Panoply::Services::AuthenticateAccount.new(options).authenticate
    end

    def self.find id
      Panoply::Repositories::Account.new.find id
    end

    def self.register options = Hash.new
      Panoply::Services::RegisterAccount.new(options).register
    end

    def self.email_taken? email
      Panoply::Repositories::Account.new.find_by_email(email) != nil
    end

  end
end