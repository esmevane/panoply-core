require 'sequel'

DB = Sequel.sqlite

DB.create_table :accounts do
  primary_key :id
  String :email
  String :name
  String :password
  DateTime :created_at
  DateTime :updated_at
end

class Sequel::Model
  plugin :validation_helpers
  plugin :timestamps

  def validate
    declare_validations
    super
  end

  def declare_validations
  end
end

class Account < Sequel::Model
  def declare_validations
    validates_presence [:name, :email, :password]
    validates_unique [:email]
  end
end

account = Account.create email: 'hay', name: 'u', password: 'guys'
